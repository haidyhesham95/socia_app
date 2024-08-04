import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

  showmodel({
    required BuildContext context,
   required void Function()? onPressed,
    required Map<String, dynamic> data,

  }) {
  return showDialog(
    context: context,

    builder: (BuildContext context) {
      return SimpleDialog(
        children: [
          FirebaseAuth.instance.currentUser!.uid == data["uid"]
              ?
          SimpleDialogOption(
            onPressed:onPressed,

            padding: const EdgeInsets.all(20),
            child: const Text(
              "Delete post",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          )
              : const SimpleDialogOption(
            padding: EdgeInsets.all(20),

            child: Text(
              "Can not delete this post ✋",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.of(context).pop();
            },
            padding: const EdgeInsets.all(20),
            child: const Text(
              "Cancel",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      );
    },
  );
}
