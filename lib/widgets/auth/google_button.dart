import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../screens/root_screen.dart';
import 'google_signIn_manager.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>((Colors.white.withOpacity(0.8))),
          // side: MaterialStateProperty.all<BorderSide>(BorderSide)
        ),
        onPressed: () async {
          final user = await GoogleSignInManager().signInWithGoogle(context);
          if (!context.mounted || user == null) return;
          if (!context.mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const RootScreen(),
            ),
          );
        },
        icon: const Icon(
          Ionicons.logo_google,
          color: Colors.red,
        ),
        label: const Text(
          'sign in with Google',
          style: TextStyle(color: Colors.black),
        ));
  }
}
