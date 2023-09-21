import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/providers/product_provider.dart';

class GoogleSignInManager {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuth =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuth.accessToken,
          idToken: googleSignInAuth.idToken,
        );
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('users');

        if (authResult.additionalUserInfo!.isNewUser) {
          await usersCollection
              .doc(authResult.user!
                  .uid)
          // Use user's authentication ID as Firestore document ID
              .set({
                'name': authResult.user!.displayName,
                'id': authResult.user!.uid,
                'emailAddress': authResult.user!.email,
                'userImage': authResult.user!.photoURL,
                'cart': [],
                'wishList':[]
              })
              .then((value) => print("User Added"))
              .catchError((error) => print("Failed to add user: $error"));
        }

        final User? user = authResult.user;
        return user;
      } else {
        return null; // User canceled the sign-in process
      }
    } catch (error) {
      Center(child: SelectableText("Error signing in with Google: $error"));
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
