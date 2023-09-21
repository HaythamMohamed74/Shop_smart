import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier {
  final String name;
  final String emailAddress;
  final String userId;
  final String? userImage;

  // final Timestamp createdAt;
  final List cart, wishList;

  UserModel(
      {required this.name,
      required this.emailAddress,
      required this.userId,
      required this.userImage,
      // required this.createdAt,
      required this.cart,
      required this.wishList});
}
