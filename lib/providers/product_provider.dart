import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  // List<ProductModel> model = ProductModel.localProds;

  List<ProductModel> productsList = [];
  final productDB = FirebaseFirestore.instance.collection("products");
  Future<List<ProductModel>> fetchProducts() async {
    try {
      await productDB.get().then((productsSnapshot) {
        for (var element in productsSnapshot.docs) {
          productsList.insert(0, ProductModel.fromFirestore(element));
        }
      });
      notifyListeners();
      return productsList;
    } catch (error) {
      rethrow;
    }
  }

// Inside your ProductProvider class
  List<ProductModel> productByCategory = [];

  Future<void> fetchProductsByCategory(String category) async {
    try {
      // Fetch products from Firestore based on the category
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('category', isEqualTo: category)
          .get();
      productByCategory.clear(); // Clear the list before populating it

      for (var element in querySnapshot.docs) {
        productByCategory.add(ProductModel.fromFirestore(element));
      }

      notifyListeners();
    } catch (e) {
      // Handle any errors
      print('Error fetching products by category: $e');
    }
  }

  // List<ProductModel> searchOfProduct(String query) {
  //   List<ProductModel> searchProducts = model
  //       .where((element) =>
  //           element.productName.toLowerCase().contains(query.toLowerCase()))
  //       .toList();
  //   return searchProducts;
  // }

  ProductModel? findByProdId(String productId) {
    if (productsList
        .where((element) => element.productId == productId)
        .isEmpty) {
      return null;
    }
    return productsList.firstWhere((element) => element.productId == productId);
  }

  final userCart = FirebaseFirestore.instance.collection('users');
  User? user = FirebaseAuth.instance.currentUser;
  Future<void> addToCart(
      {required String image,
      required name,
      required price,
      required productId}) async {
    if (user == null) {
      Fluttertoast.showToast(msg: 'User not found', timeInSecForIosWeb: 3);
    } else {
      final id = user!.uid;
      final cartID = const Uuid().v4();
      try {
        await userCart.doc(id).update({
          'cart': FieldValue.arrayUnion([
            {
              'cartID': cartID,
              'productName': name,
              'price': price,
              'image': image,
              'id': productId,
              'userId': FirebaseAuth.instance.currentUser!.uid
            }
          ])
        });
        notifyListeners();
        fetchCart();
        Fluttertoast.showToast(
            msg: 'Product is added to cart', backgroundColor: Colors.green);
      } on Exception catch (e) {
        print(e.toString());
      }
    }
  }

  // Initialize an empty list to store cart items
  // Initialize an empty list to store cart items
  List<dynamic> cartItems = [];
  Future<List<Map<String, dynamic>>> fetchCart() async {
    try {
      if (user == null) {
        throw Exception("User not authorized.");
      }

      // final id = user!.uid;

      final userDoc =
          await userCart.doc(FirebaseAuth.instance.currentUser!.uid).get();

      if (!userDoc.exists) {
        throw Exception("User document does not exist.");
      }

      final userData = userDoc.data() as Map<String, dynamic>;
      cartItems = userData['cart'] ?? [];
      notifyListeners();
      return cartItems.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Error fetching cart: $e");
      return [];
    }
  }

  void deleteFromCart(String productId) async {
    final index = cartItems.indexWhere((item) => item['id'] == productId);
    if (index != -1) {
      final removedProduct = cartItems.removeAt(index);
      notifyListeners();

      if (user != null) {
        final id = user!.uid;
        try {
          await userCart.doc(id).update({
            'cart': FieldValue.arrayRemove([removedProduct]),
          });
        } catch (e) {
          print("Error removing product from Firestore: $e");
        }
      }
    }
  }

  clearCart() async {
    cartItems.clear();
    notifyListeners();
    if (user != null) {
      final id = user!.uid;
      // final cart = cartItems.isEmpty;
      try {
        await userCart.doc(id).update({
          'cart': FieldValue.delete(),
        });
      } catch (e) {
        print("Error removing product from Firestore: $e");
      }
    }
  }

  bool isProductInCart(productID) {
    for (var item in cartItems) {
      if (item['id'] == productID) {
        return true;
      }
    }
    return false;
  }

  final userWishList = FirebaseFirestore.instance.collection('users');
  Future<void> addToWish(
      {required String image,
      required name,
      required price,
      required productId}) async {
    if (user == null) {
      Fluttertoast.showToast(msg: 'User not found', timeInSecForIosWeb: 3);
    } else {
      final id = user!.uid;
      final wishID = const Uuid().v4();
      try {
        await userWishList.doc(id).update({
          'wishList': FieldValue.arrayUnion([
            {
              'wishId': wishID,
              'productName': name,
              'price': price,
              'image': image,
              'id': productId,
            }
          ])
        });
        notifyListeners();
        fetchWishList();
        Fluttertoast.showToast(
            msg: 'Product is added to wish', backgroundColor: Colors.green);
      } on Exception catch (e) {
        print(e.toString());
      }
    }
  }

  List<dynamic> wishList = [];
  Future<List<Map<String, dynamic>>> fetchWishList() async {
    try {
      if (user == null) {
        throw Exception("User not authorized.");
      }

      final id = user!.uid;

      final userDoc = await userWishList.doc(id).get();

      if (!userDoc.exists) {
        throw Exception("User document does not exist.");
      }

      final userData = userDoc.data() as Map<String, dynamic>;
      wishList = userData['wishList'] ?? [];
      notifyListeners();
      return wishList.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Error fetching wish: $e");
      return [];
    }
  }

  // Future<bool> isProductInWish({
  //   required String productId,
  //   required String image,
  //   required String name,
  //   required String price,
  // }) async {
  //   try {
  //     final productIndex =
  //         wishList.indexWhere((item) => item['id'] == productId);
  //
  //     if (productIndex != -1) {
  //       // Product is already in the wishlist, remove it
  //       wishList.removeAt(productIndex);
  //       return true; // Product removed from wishlist
  //     } else {
  //       // Product is not in the wishlist, add it
  //       final wishID = const Uuid().v4();
  //       final wishData = {
  //         'wishId': wishID, // You should provide a value for wishID
  //         'productName': name,
  //         'price': price,
  //         'image': image,
  //         'id': productId,
  //       };
  //
  //       await userWishList.doc(user!.uid).update({
  //         'wishList': FieldValue.arrayUnion([wishData])
  //       });
  //
  //       return false; // Product added to wishlist
  //     }
  //   } catch (e) {
  //     print('Error updating wishlist: $e');
  //     return false; // Handle the error as needed
  //   }
  // }

  void updateQuantity(int index, String newQuantity) {
    productsList[index].productQuantity = newQuantity;
    notifyListeners();
  }

  double calculateTotalPrice(List<dynamic> cart) {
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += double.parse(item['price']);
    }
    // notifyListeners();
    return totalPrice;
  }
}
