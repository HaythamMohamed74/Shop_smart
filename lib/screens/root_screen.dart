import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/providers/order_provider.dart';
import 'package:smart_shop/providers/wish_list_provider.dart';
import 'package:smart_shop/screens/home_screen.dart';
import 'package:smart_shop/screens/profile_screen.dart';
import 'package:smart_shop/screens/search_screen.dart';

// import 'package:smart_shop/screens/search_screen.dart';

import '../providers/product_provider.dart';
import '../providers/user_provider.dart';
import 'cart_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentIndex = 0;
  PageController? controller;
  bool isLoadingProds = true;
  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentIndex);
    fetchFCT();
  }

  Future<void> fetchFCT() async {
    try {
      // Fetch products and user info
      await Future.wait([
        Provider.of<ProductProvider>(context, listen: false).fetchProducts(),
        Provider.of<UserProvider>(context, listen: false).getUserInfo(),
      ]);

      // Fetch cart and wishlist
      await Future.wait([
        Provider.of<ProductProvider>(context, listen: false).fetchCart(),
        Provider.of<WishlistProvider>(context, listen: false).fetchWishlist(),
      ]);

      // Fetch orders
      await Provider.of<OrderProvider>(context, listen: false).fetchOrders();
    } catch (error) {
      log(error.toString());
    } finally {
      if (mounted) {
        setState(() {
          isLoadingProds = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // Dispose of resources if necessary, but avoid data fetching.
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(controller: controller, children: screens),
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          destinations: [
            const NavigationDestination(
                selectedIcon: Icon(IconlyBold.home),
                icon: Icon(IconlyLight.home),
                label: 'home'),
            const NavigationDestination(
                selectedIcon: Icon(IconlyBold.search),
                icon: Icon(IconlyLight.search),
                label: 'search'),
            NavigationDestination(
                selectedIcon: const Icon(IconlyBold.bag2),
                icon: Badge(
                    textColor: Colors.red,
                    label: Text(
                      Provider.of<ProductProvider>(context)
                          .cartItems
                          .length
                          .toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    child: const Icon(IconlyLight.bag2)),
                label: 'cart'),
            const NavigationDestination(
                selectedIcon: Icon(IconlyBold.profile),
                icon: Icon(IconlyLight.profile),
                label: 'profile')
          ],
          onDestinationSelected: (int index) {
            setState(() {
              currentIndex = index;
            });
            controller?.jumpToPage(currentIndex);
          },
        ));
  }
}
