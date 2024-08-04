import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instgram/utless/style/colors.dart';
import 'package:instgram/utless/wiget/circle_image.dart';

import 'message.dart';




class ChatScreen extends StatelessWidget {
  final String peerId;
  final String peerName;
  final String peerImage;

  ChatScreen({required this.peerId, required this.peerName, super.key, required this.peerImage});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final chatId = getChatId(currentUserId, peerId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(peerImage),
            ),
            SizedBox(width: 8),

            Text(' $peerName'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(chatId)
                  .collection('messages')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator( color: AppColors.movv,));
                }

                final docs = snapshot.data?.docs ?? [];

                return ListView.builder(
                  reverse: true,
                  itemCount: docs.length,
                  itemBuilder: (ctx, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    final isMe = data['userId'] == currentUserId;

                    return MessageBubble(
                      message: data['text'],
                      isMe: isMe,
                      userId: data['userId'],
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Fetch the current user's profile image
                // FutureBuilder<DocumentSnapshot>(
                //   future: FirebaseFirestore.instance
                //       .collection('users')
                //       .doc(currentUserId)
                //       .get(),
                //   builder: (ctx, userSnapshot) {
                //     if (userSnapshot.connectionState == ConnectionState.waiting) {
                //       return CircleAvatar(
                //         backgroundColor: Colors.grey,
                //       );
                //     }
                //
                //     final userData = userSnapshot.data?.data() as Map<String, dynamic>?;
                //     final profileImageUrl = userData?['image'] ?? 'https://via.placeholder.com/150';
                //
                //     return CircleAvatar(
                //       backgroundImage: NetworkImage(profileImageUrl),
                //     );
                //   },
                // ),
                SizedBox(width: 8),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    color: Colors.white,
                    child: TextField(
                      controller: _controller,
                      //decoration: const InputDecoration(hintText: 'Send a message...'),
                      decoration: const InputDecoration(                      
                        hintText: '  Message...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                    
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: AppColors.movv,
                  shape: const CircleBorder(),
                  child: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final chatId = getChatId(currentUserId, peerId);

      final messageData = {
        'text': _controller.text,
        'createdAt': Timestamp.now(),
        'userId': currentUserId,
      };

      FirebaseFirestore.instance.collection('chats').doc(chatId).collection('messages').add(messageData);

      FirebaseFirestore.instance.collection('chats').doc(chatId).set({
        'users': [currentUserId, peerId],
        'lastMessage': _controller.text,
        'lastMessageAt': Timestamp.now(),
      }, SetOptions(merge: true));

      _controller.clear();
    }
  }

  String getChatId(String userId, String peerId) {
    return userId.hashCode <= peerId.hashCode ? '$userId-$peerId' : '$peerId-$userId';
  }
}

