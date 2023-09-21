import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_shop/providers/wish_list_provider.dart';

import '../../constant/assets_helper.dart';
import '../../providers/product_provider.dart';
import '../../widgets/title_text.dart';

class CategoryProduct extends StatefulWidget {
  final String? selectedCategory;
  const CategoryProduct({Key? key, this.selectedCategory}) : super(key: key);

  @override
  State<CategoryProduct> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<CategoryProduct> {
  @override
  void initState() {
    super.initState();
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.fetchProductsByCategory(widget.selectedCategory!);
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final productsByCategory = productProvider.productByCategory;
    return Scaffold(
        appBar: AppBar(
          leading: Image.asset(
            AssetsHelper.appBarLogo,
            width: 70,
          ),
          leadingWidth: 60,
          title: Shimmer.fromColors(
              baseColor: Colors.red,
              highlightColor: Colors.yellow,
              child: TitleText(
                label: widget.selectedCategory!,
              )),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Column(
          children: [
            Expanded(
                child: DynamicHeightGridView(
                    itemCount: productsByCategory.length,
                    builder: (BuildContext context, int index) {
                      var product = productsByCategory[index];
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: GestureDetector(
                              onTap: () {},
                              child: FancyShimmerImage(
                                imageUrl: product.productImg,
                                // product.productImg,
                                height: 170,
                                width: 170,
                                // boxDecoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: TitleText(
                                    maxLines: 2, label: product.productName),
                              ),
                              Flexible(
                                  child: IconButton(
                                      onPressed: () {
                                        // Provider.of<WishlistProvider>(context,
                                        //         listen: false)
                                        //     .addToWishlistFirebase(productId: product.productId,context: context);
                                      },
                                      icon: Icon(
                                        Provider.of<WishlistProvider>(context)
                                                .isProductInWishlist(
                                                    productId:
                                                        product.productId)
                                            ? Icons.favorite
                                            : IconlyLight.heart,
                                        color: Colors.red,
                                      )))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: TitleText(
                                label: r'$'
                                    '${product.productPrice}',
                                // '${Provider.of<ProductProvider>(context).model[index].productPrice}',
                                fontSize: 15,
                                textColor: Colors.blue,
                              )),
                              Flexible(
                                child: Container(
                                  // width: 30,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Provider.of<ProductProvider>(context,
                                      //         listen: false)
                                      //     .addToCart(product);
                                    },
                                    child: Icon(
                                      Provider.of<ProductProvider>(context,
                                                  listen: false)
                                              .isProductInCart(
                                                  product.productId)
                                          // Provider.of<ProductProvider>(context)
                                          //         .isProductInCart(product)
                                          ? Icons.check
                                          : IconlyLight.buy,
                                      size: 27,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    },
                    // searchResults.isEmpty
                    //     ? widget.productsByCategory != null
                    //         ? widget.productsByCategory!.length
                    //         : Provider.of<ProductProvider>(context)
                    //             .model
                    //             .length
                    //     : searchResults.length,
                    crossAxisCount: 2)),
          ],
        ));
  }
}
