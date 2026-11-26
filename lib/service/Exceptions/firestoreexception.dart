class FirestoreException implements Exception {
  final String message;
  const FirestoreException(this.message);

  @override
  String toString() => message;
}
