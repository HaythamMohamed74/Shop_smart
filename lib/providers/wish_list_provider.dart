import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_shop/models/wish_model.dart';
import 'package:uuid/uuid.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishlistItems = {};

  Map<String, WishlistModel> get getWishlistItems {
    return _wishlistItems;
  }

  bool isProductInWishlist({required String productId}) {
    return _wishlistItems.containsKey(productId);
  }

  // Firebase
  final usersDB = FirebaseFirestore.instance.collection("users");
  final _auth = FirebaseAuth.instance;
  Future<void> addToWishlistFirebase(
      {required String productId, required BuildContext context}) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      Fluttertoast.showToast(msg: 'user not found ', timeInSecForIosWeb: 7);

      return;
    }
    final uid = user.uid;
    final wishlistId = const Uuid().v4();
    try {
      usersDB.doc(uid).update({
        'wishList': FieldValue.arrayUnion([
          {
            "wishlistId": wishlistId,
            'productId': productId,
          }
        ])
      });
      // await fetchWishlist();
      Fluttertoast.showToast(msg: "Item has been added to Wishlist");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchWishlist() async {
    User? user = _auth.currentUser;
    if (user == null) {
      // log("the function has been called and the user is null");
      _wishlistItems.clear();
      return;
    }
    try {
      final userDoc =
          await usersDB.doc(FirebaseAuth.instance.currentUser!.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey("wishList")) {
        return;
      }
      final lenth = userDoc.get("wishList").length;
      for (int index = 0; index < lenth; index++) {
        _wishlistItems.putIfAbsent(
          userDoc.get('wishList')[index]['productId'],
          () => WishlistModel(
            id: userDoc.get('wishList')[index]['wishlistId'],
            productId: userDoc.get('wishList')[index]['productId'],
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> removeWishlistItemFromFirebase({
    required String wishlistId,
    required String productId,
  }) async {
    User? user = _auth.currentUser;
    try {
      await usersDB.doc(user!.uid).update({
        "wishList": FieldValue.arrayRemove([
          {
            'wishlistId': wishlistId,
            'productId': productId,
          }
        ])
      });
      _wishlistItems.remove(productId);
      // await fetchWishlist();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> clearWishlistFromFirebase() async {
    User? user = _auth.currentUser;
    try {
      await usersDB.doc(user!.uid).update({"wishList": []});
      _wishlistItems.clear();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

// Local

  void addOrRemoveFromWishlist({required String productId}) {
    if (_wishlistItems.containsKey(productId)) {
      _wishlistItems.remove(productId);
    } else {
      _wishlistItems.putIfAbsent(
        productId,
        () => WishlistModel(
          id: const Uuid().v4(),
          productId: productId,
        ),
      );
    }

    notifyListeners();
  }

  void clearLocalWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
