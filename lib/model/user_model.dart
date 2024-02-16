class UserData {
  final String uid;
  final String username;
  final String imageUrl;


  UserData({required this.uid, required this.username, required this.imageUrl});

  factory UserData.fromFirestore(snapshot) {
    return UserData(
      uid: snapshot.id,
      username: snapshot['username'] ?? '',
      imageUrl: snapshot['imageUrl'] ?? '',
    );
  }
}
