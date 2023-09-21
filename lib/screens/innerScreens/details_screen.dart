import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_shop/providers/product_provider.dart';
import 'package:smart_shop/providers/wish_list_provider.dart';

import '../../models/product_model.dart';
import '../../widgets/title_text.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leadingWidth: 60,
        title: Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: const TitleText(label: 'Shop smart')),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListView(
        children: [
          FancyShimmerImage(
              imageUrl: Provider.of<ProductModel>(context).productImg,
              // 'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png',
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    Provider.of<ProductModel>(context).productName,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
                TitleText(
                  label: r'$'
                      ''
                      '${Provider.of<ProductModel>(context).productPrice}',
                  textColor: Colors.blue,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                    onPressed: () {
                      Provider.of<WishlistProvider>(context, listen: false)
                          .addOrRemoveFromWishlist(
                              productId: Provider.of<ProductModel>(context,
                                      listen: false)
                                  .productId);
                    },
                    icon: Icon(
                      Provider.of<WishlistProvider>(context, listen: false)
                              .isProductInWishlist(
                                  productId: Provider.of<ProductModel>(context)
                                      .productId)
                          ? Icons.favorite
                          : IconlyLight.heart,
                      color: Colors.red,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white.withOpacity(0.4)),
                  ),
                  onPressed: () {
                    ProductProvider productProvider =
                        Provider.of<ProductProvider>(context, listen: false);
                    productProvider.addToCart(
                        image: Provider.of<ProductModel>(context, listen: false)
                            .productImg,
                        name: Provider.of<ProductModel>(context, listen: false)
                            .productName,
                        price: Provider.of<ProductModel>(context, listen: false)
                            .productPrice,
                        productId:
                            Provider.of<ProductModel>(context, listen: false)
                                .productId);
                    // if (productProvider.isProductInCart(model)) {
                    //   // productProvider.removeFromCart(model);
                    // } else {
                    //   // productProvider.addToCart(model);
                    // }
                  },
                  child: Consumer<ProductProvider>(
                    builder: (context, productProvider, child) {
                      bool added = productProvider.isProductInCart(
                          Provider.of<ProductModel>(context, listen: false)
                              .productId);
                      return Text(
                        added ? 'Added' : 'Add',
                        style: TextStyle(
                          color: added ? Colors.black : Colors.blue,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [TitleText(label: 'About this item')],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            Provider.of<ProductModel>(context).productDesc,
            // maxLines: ,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
