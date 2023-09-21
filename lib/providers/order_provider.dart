import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/models/order_model.dart';
import 'package:smart_shop/providers/product_provider.dart';
import 'package:smart_shop/providers/user_provider.dart';
import 'package:uuid/uuid.dart';

class OrderProvider extends ChangeNotifier {
  // Map<String, OrderModel> allOrders = {};
  List<OrderModel> allOrders = [];
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final orderRef = FirebaseFirestore.instance
      .collection('orders')
      // .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .withConverter<OrderModel>(
        fromFirestore: (snapshot, _) =>
            OrderModel.fromFireStore(snapshot.data()!),
        toFirestore: (order, _) => order.toFireStore(),
      );

  Future<void> add(
      {required BuildContext context,
      required String productId,
      required String productImage,
      required String productName,
      required String productPrice,
      required String productDesc,
      required String productQty}) async {
    final orderId = const Uuid().v4();
    final newOrder = OrderModel(
      productId: productId,
      productImage: productImage,
      productPrice: productPrice,
      productDesc: productDesc,
      productQty: productQty,
      orderId: orderId,
      userID: userId,
      userName:
          Provider.of<UserProvider>(context, listen: false).userModel!.name,
      orderTime: Timestamp.now(),
      productName: productName,
    );
    try {
      await orderRef.doc(orderId).set(newOrder);
      fetchOrders();
      notifyListeners();

      Fluttertoast.showToast(
          msg: 'products ordering',
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green);
      if (!context.mounted) return;
      Provider.of<ProductProvider>(context, listen: false).clearCart();
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchOrders() async {
    try {
      QuerySnapshot<OrderModel> snapshot = await orderRef
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      // Directly access the List of QueryDocumentSnapshot<OrderModel>
      List<OrderModel> orders = snapshot.docs.map((doc) => doc.data()).toList();
      allOrders.clear();
      // Add the fetched orders to the existing allOrders list
      for (var order in orders) {
        allOrders.insert(0, order);
      }
      notifyListeners();

      // Print the list of OrderModel instances (for debugging)
      print(orders);
    } catch (e) {
      print("Error fetching orders: $e");
    }
  }

  void deleteProductOrder(OrderModel orderModel) async {
    try {
      await orderRef.doc(orderModel.orderId).delete();
      allOrders.remove(orderModel);
      notifyListeners();
    } catch (e) {
      print("Error deleting order: $e");
    }
  }

// Future<void> fetchOrders() async {
  //   try {
  //     final QuerySnapshot<OrderModel> querySnapshot = await orderRef.get();
  //
  //     if (querySnapshot.docs.isNotEmpty) {
  //       // Clear the existing orders before populating
  //       allOrders.clear();
  //
  //       for (final QueryDocumentSnapshot<OrderModel> doc
  //           in querySnapshot.docs) {
  //         final order = doc.data(); // Automatically converted to OrderModel
  //         allOrders[doc.id] = order;
  //       }
  //     }
  //   } catch (e) {
  //     print("Error fetching orders: $e");
  //   }
  // }
}
