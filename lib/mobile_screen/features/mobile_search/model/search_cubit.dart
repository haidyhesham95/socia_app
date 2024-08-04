import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  TextEditingController controller = TextEditingController();
 bool isLoading = false;



  Timer? _debounce;

  void onTextChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchUser(query);
    });
  }

  void searchUser(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where("name", isGreaterThanOrEqualTo: query)
          .where("name", isLessThan: query + 'z')
          .get();

      emit(SearchSuccess(querySnapshot.docs));
    } catch (e) {
      emit(SearchError());
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}






