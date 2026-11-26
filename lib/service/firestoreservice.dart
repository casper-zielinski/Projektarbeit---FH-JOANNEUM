import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/service/Exceptions/firestoreexception.dart';
import 'package:flutterapp/service/dto/post.dart';
import 'package:flutterapp/service/dto/user.dart';

class Firestoreservice {
  final CollectionReference<Post> _postsRef = FirebaseFirestore.instance
      .collection('posts')
      .withConverter<Post>(
        fromFirestore: (snapshot, _) => Post.fromFirestore(snapshot),
        toFirestore: (post, _) => post.toFirestore(),
      );

  final CollectionReference<UserDto> _usersRef = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserDto>(
        fromFirestore: (snapshot, _) => UserDto.fromFirestore(snapshot),
        toFirestore: (user, _) => user.toFirestore(),
      );

  Stream<List<Post>> getPostsStream() {
    return _postsRef
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<void> sendPost({
    required UserDto? userDto,
    required String text,
  }) async {
    if (userDto != null) {
      UserDto user = userDto;
      await _postsRef.add(
        Post(
          numberOfComments: 0,
          likes: List.empty(),
          name: user.name,
          text: text,
          timeStamp: DateTime.now(),
          userFromUserTableId: user.id ?? user.uid,
          userId: user.uid,
          useremail: user.email,
          username: user.username,
        ),
      );
    } else {
      throw const FirestoreException(
        'Could not send post, no user was found. Please log in again.',
      );
    }
  }

  Future<void> likePost(String postId, String useremail) async {
    final docRef = _postsRef.doc(postId);
    final postSnapshot = await docRef.get();
    if (!postSnapshot.exists) return;

    final List<String> likes = postSnapshot.data()?.likes ?? [];

    if (likes.contains(useremail)) {
      await docRef.update({
        'likes': FieldValue.arrayRemove([useremail]),
      });
    } else {
      await docRef.update({
        'likes': FieldValue.arrayUnion([useremail]),
      });
    }
  }

  Future<void> createUser({
    required String uid,
    required String email,
    required String name,
    required String username,
  }) async {
    await _usersRef.add(
      UserDto(
        totalLikes: 0,
        uid: uid,
        email: email,
        name: name,
        username: username,
      ),
    );
  }

  Future<UserDto?> getUser(String uid) async {
    final snapshot = await _usersRef
        .where('UID', isEqualTo: uid)
        .limit(1)
        .get();
    return snapshot.docs.isEmpty ? null : snapshot.docs.first.data();
  }
}
