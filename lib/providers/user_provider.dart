import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  Future<UserModel?> getUserInfo() async {
    FirebaseAuth? user = FirebaseAuth.instance;
    if (user.currentUser == null) {
      return null;
    }
    try {
      print("Fetching user info for UID: ${user.currentUser!.uid}");
      final docs = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.currentUser!.uid)
          .get();
      // map the return is map ;
      final userMap = docs.data();
      _userModel = UserModel(
          name: docs.get('name'),
          emailAddress: docs.get('emailAddress'),
          userId: docs.get('id'),
          userImage: docs.get('userImage'),
          cart: userMap!.containsKey('cart') ? docs.get('cart') : [],
          wishList:
              userMap.containsKey('wishList') ? docs.get('wishList') : []);
      return userModel;
    } on FirebaseException catch (e) {
      debugPrint("error is here n ${e.message.toString()}");
    } catch (error) {
      rethrow;
    }
    notifyListeners();
    return null;
  }
}
