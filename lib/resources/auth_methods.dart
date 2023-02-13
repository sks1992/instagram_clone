import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/users.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
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
    required Uint8List file,
  }) async {
    String res = "Some Error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print("UserId :: ${cred.user!.uid}");

        String imageUrl = await StorageMethods()
            .uploadImageToStorage(storageCollectionName, file, false);

        Users users = Users(
          email: email,
          uid: cred.user!.uid,
          photoUrl: imageUrl,
          userName: userName,
          bio: bio,
          following: [],
          followers: [],
        );
        await _firestore
            .collection(cloudCollectionName)
            .doc(cred.user!.uid)
            .set(
              users.toJson(),
            );

        //code when we don't  use model for send data
        //add user to Cloud Firestore Database
        // await _firestore
        //     .collection(cloudCollectionName)
        //     .doc(cred.user!.uid)
        //     .set({
        //   "userName": userName,
        //   "uid": cred.user!.uid,
        //   "email": email,
        //   "bio": bio,
        //   "followers": [],
        //   "following": [],
        //   "imageUrl": imageUrl,
        // });

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

        res = "success";
      } else {
        res = "Please Fill all the Fields";
      }
    }
    /*on FirebaseAuthException catch (err) {
      if (err.code == "invalid-error") {
        res = "The Email is Badly Formatted";
      } else if (err.code == "weak-password") {
        res = "Password Should Be More tan 6 Character";
      }
    } */
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some Error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please Fill all the Fields";
      }
      // } on FirebaseAuthException catch (err) {
      //   if (err.code == "user-not-found") {
      //     res = "User not Exists";
      //   } else if (err.code == "wrong-password") {
      //     res = "Please Enter Correct Password";
      //   }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<Users> getUserDetails() async {
    User _currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot = await _firestore
        .collection(cloudCollectionName)
        .doc(_currentUser.uid)
        .get();

    return Users.fromSnap(snapshot);
  }
}
