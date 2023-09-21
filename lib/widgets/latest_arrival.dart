import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/providers/product_provider.dart';
import 'package:smart_shop/providers/recent_view.dart';
import 'package:smart_shop/widgets/heart_button.dart';
import 'package:smart_shop/widgets/title_text.dart';

import '../screens/innerScreens/details_screen.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  const LatestArrivalProductsWidget({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final latestProducts = Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          final recent = Provider.of<RecentViewProvider>(context, listen: false)
              .addToRecent(latestProducts.productsList[index]);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ChangeNotifierProvider.value(
                          value: latestProducts.productsList[index],
                          child: const DetailsScreen())));
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FancyShimmerImage(
                    imageUrl: latestProducts.productsList[index].productImg,
                    width: size.width * 0.28,
                    height: size.width * 0.28,
                  ),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      latestProducts.productsList[index].productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          HeartButtonWidget(
                              productId:
                                  latestProducts.productsList[index].productId),
                          GestureDetector(
                            onTap: () {
                              Provider.of<ProductProvider>(context,
                                      listen: false)
                                  .addToCart(
                                      image: latestProducts
                                          .productsList[index].productImg,
                                      name: latestProducts
                                          .productsList[index].productName,
                                      price: latestProducts
                                          .productsList[index].productPrice,
                                      productId: latestProducts
                                          .productsList[index].productId);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Provider.of<ProductProvider>(context)
                                        .isProductInCart(latestProducts
                                            .productsList[index].productId)
                                    ? Icons.check
                                    : IconlyLight.buy,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: TitleText(
                        label: r'$'
                            '${latestProducts.productsList[index].productPrice}',
                        textColor: Colors.blue,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
