import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/providers/order_provider.dart';
import 'package:smart_shop/providers/product_provider.dart';
import 'package:smart_shop/widgets/title_text.dart';

class ButtomSheetWidget extends StatelessWidget {
  const ButtomSheetWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 45,
            child: Column(
              children: [
                TitleText(
                  label:
                      'Total items is : ${Provider.of<ProductProvider>(context).cartItems.length}',
                  fontSize: 15,
                ),
                Text(
                  '  totalPrice ${Provider.of<ProductProvider>(context, listen: false).calculateTotalPrice(Provider.of<ProductProvider>(context).cartItems)}',
                  // style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>((Colors.cyan)),
                // side: MaterialStateProperty.all<BorderSide>(BorderSide)
              ),
              onPressed: () {
                final cartProvider =
                    Provider.of<ProductProvider>(context, listen: false)
                        .cartItems;
                final provider =
                    Provider.of<ProductProvider>(context, listen: false);
                try {
                  cartProvider.forEach((element) {
                    final getCurrentProduct =
                        provider.findByProdId(element['id']);
                    Provider.of<OrderProvider>(context, listen: false).add(
                        productId: getCurrentProduct!.productId,
                        productImage: getCurrentProduct.productImg,
                        productPrice: getCurrentProduct.productPrice,
                        productDesc: getCurrentProduct.productPrice,
                        productQty: getCurrentProduct.productQuantity,
                        context: context,
                        productName: getCurrentProduct.productName);
                  });
                  // cartProvider.clear();
                } on Exception catch (e) {
                  print(e.toString());
                }
              },
              child: const Text('checkout'))
        ],
      ),
    );
  }
}
