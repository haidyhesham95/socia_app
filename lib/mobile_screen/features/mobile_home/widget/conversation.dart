import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../generated/assets.dart';
import '../../../../utless/style/colors.dart';
import '../../mobile_profile/widget/chat_screen.dart';




class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('chats'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('users', arrayContains: currentUserId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return  Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.imagesNochat),
                const SizedBox(height: 15),
                Text('No conversation yet', style: TextStyle(fontSize: 20,color: AppColors.movv.withOpacity(0.7),fontWeight: FontWeight.w500)),
              ],
            ));
          }

          final chatDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chatDocs.length,
            itemBuilder: (ctx, index) {
              final chatData = chatDocs[index].data() as Map<String, dynamic>;
              final peerId = chatData['users'].firstWhere((id) => id != currentUserId);
              final lastMessage = chatData['lastMessage'] ?? '';

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('users').doc(peerId).get(),
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const ListTile(
                      title: Text('Loading...'),
                    );
                  }

                  if (!userSnapshot.hasData) {
                    return const ListTile(
                      title: Text('User not found'),
                    );
                  }

                  final peerData = userSnapshot.data!.data() as Map<String, dynamic>;
                  final peerName = peerData['name'] ?? 'Unknown';
                  final profileImageUrl = peerData['image'] ?? '';

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: profileImageUrl.isNotEmpty
                          ? NetworkImage(profileImageUrl)
                          : const AssetImage('assets/images/profileavatar.jpg') as ImageProvider,
                    ),
                    title: Text(peerName),
                    subtitle: Text(lastMessage),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(peerId: peerId, peerName: peerName, peerImage: profileImageUrl),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
