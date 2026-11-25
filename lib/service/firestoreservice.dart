import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/service/dto/post.dart';

class Firestoreservice {
  final CollectionReference<Post> _postsRef = FirebaseFirestore.instance
      .collection('posts')
      .withConverter<Post>(
        fromFirestore: (snapshot, _) => Post.fromFirestore(snapshot),
        toFirestore: (post, _) => post.toFirestore(),
      );

  Stream<List<Post>> getPostsStream() {
    return _postsRef
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
