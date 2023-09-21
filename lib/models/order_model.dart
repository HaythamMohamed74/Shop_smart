import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String productId;
  final String userID;
  final String userName;
  final String productName;
  final String productImage;
  final String productPrice;
  final String productDesc;
  final String productQty;
  final String orderId;
  final Timestamp orderTime;
  OrderModel(
      {required this.productName,
      required this.productId,
      required this.userID,
      required this.userName,
      required this.orderTime,
      required this.productImage,
      required this.productPrice,
      required this.productDesc,
      required this.productQty,
      required this.orderId});
  OrderModel.fromFireStore(Map<String, Object?> data)
      : this(
            productId: data['productId']! as String,
            productImage: data['productImage']! as String,
            productPrice: data['productPrice']! as String,
            productDesc: data['productDesc']! as String,
            productQty: data['productQty']! as String,
            orderId: data['orderId']! as String,
            userID: data['userId']! as String,
            orderTime: data['orderTime'] as Timestamp,
            userName: data['userName']! as String,
            productName: data['productName']! as String);

  Map<String, Object?> toFireStore() {
    return {
      'productId': productId,
      'productImage': productImage,
      'productPrice': productPrice,
      'productDesc': productDesc,
      'productQty': productQty,
      'orderId': orderId,
      'userId': userID,
      'orderTime': orderTime,
      'userName': userName,
      'productName': productName
    };
  }
}
