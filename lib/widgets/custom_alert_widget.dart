import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constant/assets_helper.dart';
import '../screens/auth/login_screen.dart';
import 'auth/google_signIn_manager.dart';

Future<void> alertDialogWidget(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.blueGrey,
          content: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.2,
            child: Column(
              children: [
                Image.asset(
                  AssetsHelper.warning,
                  width: MediaQuery.sizeOf(context).width * 0.2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>((Colors.cyan)),
                          // side: MaterialStateProperty.all<BorderSide>(BorderSide)
                        ),
                        onPressed: () async {
                          final googleSignInManager = GoogleSignInManager();
                          await googleSignInManager.signOut();
                          await FirebaseAuth.instance.signOut();
                          // Provider.of<SignIn>(context, listen: false).SignOut();
                          if (!context.mounted) return;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text('ok')),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>((Colors.red)),
                          // side: MaterialStateProperty.all<BorderSide>(BorderSide)
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('cancel'))
                  ],
                )
              ],
            ),
          ),
        );
      });
}
