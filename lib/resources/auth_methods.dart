import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:wordfight/models/user.dart' as model;
import 'package:wordfight/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    if (_auth.currentUser!.isAnonymous == true) {
      return model.User(
        username: _auth.currentUser!.uid,
        email: 'null',
        password: 'null',
        photoUrl:
            'https://firebasestorage.googleapis.com/v0/b/word-fight-df368.appspot.com/o/profilePics%2Fdefault_profile_pic.png?alt=media&token=81a3d96d-834e-49ce-b947-066364162dac',
      );
    } else {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userSnap =
          await _firestore.collection('users').doc(uid).get();

      return model.User.userModelFromSnap(userSnap);
    }
  }

  Future<String> userSignUp({
    required String email,
    required String password,
    required String username,
    Uint8List? file,
  }) async {
    String res = 'Some error occured';
    if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
      try {
        if (file == null) {
          final ByteData bytes =
              await rootBundle.load('assets/default_profile_pic.png');
          file = bytes.buffer.asUint8List();
        }

        UserCredential userCred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        //Uploading image to storage
        String photoUrl =
            await StorageMethods().uploadImageToStorage('profilePics', file);

        model.User user = model.User(
          username: username,
          password: password,
          email: email,
          photoUrl: photoUrl,
        );
        await _firestore
            .collection('users')
            .doc(userCred.user!.uid)
            .set(user.toJson());

        res = 'success';
      } on FirebaseAuthException catch (e) {
        res = e.code;
      } catch (e) {
        res = e.toString();
      }
    } else {
      res = 'Nie uzupełniłeś wszystkich pól';
    }

    return res;
  }

  Future<String> userSignIn(String email, String password) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Nie uzupełniłeś wszystkich pól';
      }
    } on FirebaseAuthException catch (e) {
      res = e.code;
    }
    return res;
  }

  Future<String> signInAnonymously() async {
    String res = 'Some error occured';

    try {
      res = 'success';
    } on FirebaseAuthException catch (e) {
      res = e.code;
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> signOut() async {
    String res = 'Some error occured';
    try {
      await _auth.signOut();
      res = 'success';
    } on FirebaseAuthException catch (e) {
      res = e.code;
    }
    return res;
  }
}
