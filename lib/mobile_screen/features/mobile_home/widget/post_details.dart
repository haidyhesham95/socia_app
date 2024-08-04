// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import 'comment_screen.dart';
//
// class PostDetails extends StatelessWidget {
//   final Map<String, dynamic> data;
//   final int commentCount;
//
// const  PostDetails({super.key, required this.data, required this.commentCount});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: double.infinity,
//             child: Text(
//               '${data['likes'].length} ${data['likes'].length > 1 ? 'likes' : 'like'}',
//               style: TextStyle(color: Colors.grey),
//             ),
//           ),
//           Row(
//             children: [
//               Text(
//                 '${data['username']}',
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),
//               SizedBox(width: 5),
//               Text('${data['description']}',
//               ),
//             ],
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => CommentScreen(data: data, commentText: true,)),
//               );
//             },
//             child: Container(
//               width: double.infinity,
//               child: Text(
//                 "View all $commentCount comments",
//                 style: TextStyle(color: Colors.grey.shade700),
//               ),
//             ),
//           ),
//           Text(
//             DateFormat('d MMM, yyyy').format((data['datePublished'] as Timestamp).toDate()),
//             style: TextStyle(color: Colors.grey.shade700),
//           ),
//         ],
//       ),
//     );
//   }
// }
