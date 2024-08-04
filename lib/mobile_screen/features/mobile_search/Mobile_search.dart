import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utless/style/colors.dart';
import '../mobile_profile/view/mobile_profile.dart';
import 'model/search_cubit.dart';



class MobileSearch extends StatelessWidget {
  const MobileSearch({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: context.read<SearchCubit>().controller,
              onChanged: (value) {
                context.read<SearchCubit>().onTextChanged(value);
              },
              decoration: const InputDecoration(
                hintText: 'Search for users',

                prefixIcon: Icon(Icons.search),
                prefixIconColor: AppColors.movv,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.movv),
                  borderRadius: BorderRadius.all(Radius.circular(12)),

                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.movv),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.movv),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.movv),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),

          BlocConsumer<SearchCubit, SearchState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is SearchLoading) {
                return const Center(child: CircularProgressIndicator( color: AppColors.movv,));
              }
              if (state is SearchError) {
                return const Center(
                  child: Text('Error'),
                );
              }
              if (state is SearchSuccess) {
                return Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 15);
                    },
                    itemCount: state.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                           Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MobileProfile(
                                uid: state.results[index]["id"],
                               ),

                            ),
                          );


                        },
                        title: Text(state.results[index]["name"]),
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage:
                          NetworkImage(state.results[index]["image"]),
                        ),
                      );
                    },
                  ),
                );
              }
              return const Text('');
            },
          ),
        ],
      ),
    );
  }
}
