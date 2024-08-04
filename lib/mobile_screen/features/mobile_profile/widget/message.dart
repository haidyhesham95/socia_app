import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instgram/utless/style/colors.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String userId;

  const MessageBubble({
    required this.message,
    required this.isMe,
    required this.userId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
      builder: (ctx, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return SizedBox.shrink();
        }

        final userData = userSnapshot.data?.data() as Map<String, dynamic>?;
        final profileImageUrl = userData?['image'] ?? 'https://via.placeholder.com/150';

        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          width: double.infinity,
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              // if (!isMe) ...[
              //   CircleAvatar(
              //     backgroundImage: NetworkImage(profileImageUrl),
              //   ),
              //   SizedBox(width: 8),
              // ],
              Material(
                borderRadius: BorderRadius.only(
                  topLeft: isMe ? Radius.circular(10) : Radius.zero,
                  topRight: isMe ? Radius.zero : Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                elevation: 5,
                color: isMe ? AppColors.movv.withOpacity(0.7) : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              // if (isMe) ...[
              //   SizedBox(width: 8),
              //   CircleAvatar(
              //     backgroundImage: NetworkImage(profileImageUrl),
              //   ),
              // ],
            ],
          ),
        );
      },
    );
  }
}
