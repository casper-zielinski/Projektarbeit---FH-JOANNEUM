import 'package:cloud_firestore/cloud_firestore.dart';

class UserDto {
  final String? id;
  final int totalLikes;
  final String uid;
  final String email;
  final String name;
  final String username;

  UserDto({
    this.id,
    required this.totalLikes,
    required this.uid,
    required this.email,
    required this.name,
    required this.username,
  });

  factory UserDto.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UserDto(
      id: doc.id,
      totalLikes: data['Totallikes'] ?? 0,
      uid: data['UID'] ?? '',
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      username: data['username'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Totallikes': totalLikes,
      'UID': uid,
      'email': email,
      'name': name,
      'username': username,
    };
  }
}
