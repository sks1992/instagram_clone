import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String description;
  final String uid;
  final String postId;
  final String userName;
  final datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  PostModel({
    required this.description,
    required this.uid,
    required this.postId,
    required this.userName,
    required this.datePublished,
    required this.postUrl,
    required this.profileImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['description'] = description;
    data['datePublished'] = datePublished;
    data['postId'] = postId;
    data['uid'] = uid;
    data['userName'] = userName;
    data['postUrl'] = postUrl;
    data['profileImage'] = profileImage;
    data['likes'] = likes;
    return data;
  }

  static PostModel fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return PostModel(
      description: snapShot["description"],
      uid: snapShot["uid"],
      postId: snapShot["postId"],
      userName: snapShot["userName"],
      datePublished: snapShot["datePublished"],
      postUrl: snapShot["postUrl"],
      profileImage: snapShot["profileImage"],
      likes: snapShot["likes"],
    );
  }
}
