import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_shop/widgets/auth/elevated_icon_button.dart';

import '../../widgets/auth/register_class.dart';
import '../../widgets/picked_image.dart';
import '../../widgets/text_form_field.dart';
import '../../widgets/title_text.dart';
import '../root_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // File? pickedImage;
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPassController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool hidePass = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    userController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repeatPassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseFirestore firestore = FirebaseFirestore.instance;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: ListView(
              // physics: const NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Shimmer.fromColors(
                      baseColor: Colors.red,
                      highlightColor: Colors.yellow,
                      child: const TitleText(
                        label: 'ShopSmart',
                        fontSize: 35,
                      )),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: TitleText(
                        label: 'Welcome ',
                        fontSize: 30,
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          'Sign up now to receive special offers and updates from our app  ')),
                ),
                const Center(
                  child: CustomPickedImage(),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                    controller: userController,
                    hintText: 'user ',
                    prefix: const Icon(IconlyLight.user2),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                    controller: emailController,
                    hintText: 'user@gmail.com ',
                    prefix: const Icon(IconlyLight.message),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: '*************',
                  prefix: const Icon(IconlyLight.password),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'password is required';
                    } else {
                      return null;
                    }
                  },
                  obscure: hidePass,
                  customSuffix: IconButton(
                    onPressed: () {
                      hidePass = !hidePass;
                      setState(() {});
                    },
                    icon: hidePass
                        ? const Icon(IconlyLight.hide)
                        : const Icon(IconlyLight.show),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // CustomTextFormField(
                //   controller: repeatPassController,
                //   hintText: 'confirm password',
                //   validator: (val) {
                //     if (val!.isEmpty) {
                //       return 'repeat password is required';
                //     } else {
                //       return null;
                //     }
                //   },
                //   obscure: true,
                //   prefix: const Icon(IconlyLight.password),
                // ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedIconButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Register().register(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            context,
                            userController.text);
                      }
                      if (!context.mounted) return;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const RootScreen()));
                    },
                    icon: Icons.login,
                    label: 'Register')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
