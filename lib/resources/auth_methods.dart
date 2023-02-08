import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/util/constants.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //signup user
  Future<String> signupUser({
    required String email,
    required String password,
    required String userName,
    required String bio,
    //required Uint8List file,
  }) async {
    String res = "Some Error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          bio.isNotEmpty /*||
          file != null*/) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print("UserId :: ${cred.user!.uid}");
     
        //add user to Cloud Firestore Database
       await  _firestore.collection(cloudCollectionName).doc(cred.user!.uid).set({
          "userName":userName,
          "uid":cred.user!.uid,
          "email":email,
          "bio":bio,
          "followers":[],
          "following":[],
        });

        // add user to Cloud Firestore Database  using add method by using this
        // method we get different DocumentId and uid if we want  to get same
        // userId then use above method
        // await  _firestore.collection(cloudCollectionName).add({
        //   "userName":userName,
        //   "uid":cred.user!.uid,
        //   "email":email,
        //   "bio":bio,
        //   "followers":[],
        //   "following":[],
        // });


        res ="success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
