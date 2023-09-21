import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_shop/screens/auth/register_screen.dart';
import 'package:smart_shop/screens/root_screen.dart';
import 'package:smart_shop/widgets/auth/sign_in_class.dart';

import '../../widgets/auth/google_button.dart';
import '../../widgets/text_form_field.dart';
import '../../widgets/title_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool obscure = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(
                  height: 70,
                ),
                Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.yellow,
                    child: const TitleText(
                      label: 'ShopSmart',
                      fontSize: 35,
                    )),
                const SizedBox(
                  height: 25,
                ),
                const Row(
                  children: [
                    TitleText(label: 'Welcome Back'),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomTextFormField(
                  controller: emailController,
                  hintText: 'user@gmail.com',
                  prefix: const Icon(IconlyLight.message),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  controller: passwordController,
                  obscure: obscure,
                  hintText: '**********',
                  prefix: const Icon(IconlyLight.password),
                  customSuffix: IconButton(
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    icon: Icon(obscure
                        ? Icons.remove_red_eye
                        : Icons.lock_open_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {},
                        child: const TitleText(
                          label: 'Forget password ?',
                          textColor: Colors.blue,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              (Colors.white.withOpacity(0.8))),
                          // side: MaterialStateProperty.all<BorderSide>(BorderSide)
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await SignIn().signIn(emailController.text,
                                passwordController.text, context);
                          }
                          if (!context.mounted) return;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const RootScreen()));
                        },
                        child: const Text(
                          ' Sign in ',
                          style: TextStyle(color: Colors.black),
                        ))),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText(
                      label: 'Or Connect Using ',
                      textColor: Colors.grey,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const GoogleButton(),
                    // Icon(Icons.go)
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              (Colors.white.withOpacity(0.8))),
                          // side: MaterialStateProperty.all<BorderSide>(BorderSide)
                        ),
                        onPressed: () {
                          // Navigator.pop(context);
                        },
                        child: const Text(
                          'Guest?',
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(" Don't have an account? "),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => const RegisterScreen()));
                        },
                        child: const Text('Sign up')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
