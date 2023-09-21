import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_shop/providers/order_provider.dart';

import '../../constant/assets_helper.dart';
import '../../widgets/empty_cart_screen.dart';
import '../../widgets/title_text.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          AssetsHelper.appBarLogo,
          width: 70,
        ),
        title: Shimmer.fromColors(
          baseColor: Colors.red,
          highlightColor: Colors.yellow,
          child: const TitleText(
            label: 'Orders',
          ),
        ),
      ),
      body: Provider.of<OrderProvider>(context).allOrders.isEmpty
          ? EmptyScreen(img: AssetsHelper.emptyOrder, pageName: ' orders   ')
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: ListView.builder(
                  itemCount:
                      Provider.of<OrderProvider>(context).allOrders.length,
                  itemBuilder: (BuildContext context, int index) {
                    final order =
                        Provider.of<OrderProvider>(context).allOrders[index];
                    return FittedBox(
                      child: IntrinsicWidth(
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: FancyShimmerImage(
                                  imageUrl: order.productImage,
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                            ),
                            IntrinsicWidth(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: TitleText(
                                      label: Provider.of<OrderProvider>(context)
                                          .allOrders[index]
                                          .productName,
                                      maxLines: 2,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TitleText(
                                          // label: getCurrentProduct.productPrice,
                                          label:
                                              '\$${Provider.of<OrderProvider>(context).allOrders[index].productPrice}',
                                          textColor: Colors.grey,
                                        ),
                                        const SizedBox(
                                          width: 100,
                                        ),
                                        const SizedBox(width: 8),
                                      ]),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Provider.of<OrderProvider>(context,
                                            listen: false)
                                        .deleteProductOrder(
                                            Provider.of<OrderProvider>(context,
                                                    listen: false)
                                                .allOrders[index]);
                                    // setState(() {});
                                  },
                                  icon: const Icon(
                                    IconlyLight.delete,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  Provider.of<OrderProvider>(context)
                                      .allOrders[index]
                                      .productQty,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 60),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
