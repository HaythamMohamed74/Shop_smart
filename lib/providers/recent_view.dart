import 'package:flutter/cupertino.dart';

import '../models/product_model.dart';

class RecentViewProvider extends ChangeNotifier {
  List<ProductModel> recent = [];
  addToRecent(ProductModel productModel) {
    if (!recent.contains(productModel)) {
      recent.add(productModel);
    } else {
      recent.remove(productModel);
    }

    // notifyListeners();
  }
}
