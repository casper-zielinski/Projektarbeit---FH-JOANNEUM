import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String? id; 
  final int numberOfComments;
  final List<String> likes; 
  final String name;
  final String text;
  final DateTime timeStamp;
  final String userFromUserTableId;
  final String userId;
  final String useremail;
  final String username;

  Post({
    this.id,
    required this.numberOfComments,
    required this.likes,
    required this.name,
    required this.text,
    required this.timeStamp,
    required this.userFromUserTableId,
    required this.userId,
    required this.useremail,
    required this.username,
  });

  factory Post.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Post(
      id: doc.id,
      numberOfComments: data['NumberOfComments'] ?? 0,
      likes: List<String>.from(data['likes'] ?? []), 
      name: data['name'] ?? '',
      text: data['text'] ?? '',
      timeStamp: (data['timeStamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      userFromUserTableId: data['userFromUserTableId'] ?? '',
      userId: data['userId'] ?? '',
      useremail: data['useremail'] ?? '',
      username: data['username'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'NumberOfComments': numberOfComments,
      'likes': likes,
      'name': name,
      'text': text,
      'timeStamp': Timestamp.fromDate(timeStamp),
      'userFromUserTableId': userFromUserTableId,
      'userId': userId,
      'useremail': useremail,
      'username': username,
    };
  }
}