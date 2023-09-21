import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/constant/theme_data.dart';
import 'package:smart_shop/providers/order_provider.dart';
import 'package:smart_shop/providers/picked_image.dart';
import 'package:smart_shop/providers/product_provider.dart';
import 'package:smart_shop/providers/recent_view.dart';
import 'package:smart_shop/providers/theme_providers.dart';
import 'package:smart_shop/providers/user_provider.dart';
import 'package:smart_shop/providers/wish_list_provider.dart';
// import 'package:smart_shop/providers/wishlist_provider.dart';
import 'package:smart_shop/screens/auth/login_screen.dart';
import 'package:smart_shop/screens/root_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ThemeProvider themeProvider = ThemeProvider();
  await themeProvider.init();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Colors.blue,
          ));
        }
        if (snapshot.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: SelectableText('${snapshot.error}')));
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<ThemeProvider>(
                create: (_) => ThemeProvider()),
            ChangeNotifierProvider<PickedImage>(create: (_) => PickedImage()),
            ChangeNotifierProvider<ProductProvider>(
                create: (_) => ProductProvider()),
            ChangeNotifierProvider<WishlistProvider>(
                create: (_) => WishlistProvider()),
            ChangeNotifierProvider<RecentViewProvider>(
                create: (_) => RecentViewProvider()),
            ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
            ChangeNotifierProvider<OrderProvider>(
                create: (_) => OrderProvider()),
          ],
          child:
              Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Smart shopping',
              theme: Style.themeData(
                  isDarkTheme: themeProvider.isDarkTheme, context: context),
              home: FirebaseAuth.instance.currentUser != null
                  ? const RootScreen()
                  : const LoginScreen(),
            );
          }),
        );
      },
    );
  }
}
