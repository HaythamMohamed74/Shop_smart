import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/providers/picked_image.dart';

class Register {
  Future<void> register(String emailAddress, password, BuildContext context,
      String userName) async {
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      if (!context.mounted) return;
      User? user = FirebaseAuth.instance.currentUser;
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      if (user != null) {
        if (!context.mounted) return;
        await usersCollection
            .doc(user
                .uid) // Use user's authentication ID as Firestore document ID
            .set({
              'name': userName,
              'id': user.uid,
              'emailAddress': emailAddress,
              'userImage':
                  Provider.of<PickedImage>(context, listen: false).downloadURL,
              'cart': [],
              'wishList': []
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      }
      if (!context.mounted) return;
      // Navigator.pop(context);
      // }
      Fluttertoast.showToast(
          msg: "Account has been created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      if (!context.mounted) return;
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('weak-password')));
      } else if (e.code == 'email-already-in-use') {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('email already Exist')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('invalid email formatted')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      Navigator.pop(context);
    }
  }
}
