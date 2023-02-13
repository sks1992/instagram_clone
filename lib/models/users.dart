import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String email;
  final String uid;
  final String photoUrl;
  final String userName;
  final String bio;
  final List following;
  final List followers;

  Users({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.userName,
    required this.bio,
    required this.following,
    required this.followers,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['bio'] = bio;
    data['imageUrl'] = photoUrl;
    data['uid'] = uid;
    data['userName'] = userName;
    data['following'] = following;
    data['followers'] = followers;
    return data;
  }

  static Users fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return Users(
      email: snapShot["email"],
      uid: snapShot["uid"],
      photoUrl: snapShot["imageUrl"],
      userName: snapShot["userName"],
      bio: snapShot["bio"],
      following: snapShot["following"],
      followers: snapShot["followers"],
    );
  }
}
