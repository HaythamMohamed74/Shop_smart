import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignIn {
  Future<void> signIn(
    String emailAddress,
    String password,
    BuildContext context,
  ) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      if (!context.mounted) return;
      Navigator.pop(context);

      int atIndex = emailAddress.indexOf('@');
      String userName = emailAddress.substring(0, atIndex);
      Fluttertoast.showToast(
          msg: "Welcome $userName",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
      // Debug statement
      // print("Before navigating to RootScreen");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const RootScreen(),
      //   ),
      // );
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth exceptions
      if (e.code == 'user-not-found') {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No user found for that email.'),
          backgroundColor: Colors.red,
        ));
      } else if (e.code == 'wrong-password') {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Wrong password provided for that user.')));
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The email address is badly formatted.')));
      }
    } catch (e) {
      // Handle other exceptions
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      Navigator.pop(context);
    }
  }

  Future<void> SignOut() async {
    FirebaseAuth.instance.signOut();
  }
}
