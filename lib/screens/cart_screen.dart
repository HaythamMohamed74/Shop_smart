import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_shop/providers/product_provider.dart';
import 'package:smart_shop/widgets/empty_cart_screen.dart';

import '../constant/assets_helper.dart';
import '../widgets/buttom_sheet_widget.dart';
import '../widgets/title_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<ProductProvider>(context).cartItems.isEmpty
        ? EmptyScreen(img: AssetsHelper.order, pageName: 'Cart ')
        : Scaffold(
            bottomSheet: const ButtomSheetWidget(),
            appBar: AppBar(
              leading: Image.asset(
                AssetsHelper.appBarLogo,
                width: 70,
              ),
              title: Shimmer.fromColors(
                baseColor: Colors.red,
                highlightColor: Colors.yellow,
                child: const TitleText(
                  label: 'Shopping basket',
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Provider.of<ProductProvider>(context, listen: false)
                          .clearCart();
                    },
                    icon: const Icon(Icons.delete_outline))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: ListView.builder(
                  itemCount:
                      Provider.of<ProductProvider>(context).cartItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FittedBox(
                      child: IntrinsicWidth(
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: FancyShimmerImage(
                                  imageUrl:
                                      Provider.of<ProductProvider>(context)
                                          .cartItems[index]['image'],
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
                                      label:
                                          Provider.of<ProductProvider>(context)
                                              .cartItems[index]['productName'],
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
                                              '\$${Provider.of<ProductProvider>(context).cartItems[index]['price']}',
                                          textColor: Colors.grey,
                                        ),
                                        const SizedBox(
                                          width: 100,
                                        ),
                                        const SizedBox(width: 8),
                                        OutlinedButton.icon(
                                          onPressed: () async {
                                            showModalBottomSheet(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                              ),
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        height: 6,
                                                        width: 90,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: ListView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount: 10,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Center(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                final productProvider =
                                                                    Provider.of<
                                                                            ProductProvider>(
                                                                        context,
                                                                        listen:
                                                                            false);
                                                                productProvider
                                                                    .updateQuantity(
                                                                        index,
                                                                        selectedQty
                                                                            .toString()); // Assuming updateQuantity(index, quantity) is a method in ProductProvider
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        5.0),
                                                                child: TitleText(
                                                                    label:
                                                                        '${index + 1}'),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                              IconlyLight.arrowDown2),
                                          label: GestureDetector(
                                            onTap: () {},
                                            child: Consumer<ProductProvider>(
                                              builder: (context,
                                                  productProvider, child) {
                                                return const TitleText(
                                                  label:
                                                      'Quantity: ${1}', // Replace index with the correct index
                                                  fontSize: 15,
                                                );
                                              },
                                            ),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            side: const BorderSide(
                                                color: Colors.blue),
                                          ),
                                        )
                                      ]),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Provider.of<ProductProvider>(context,
                                            listen: false)
                                        .deleteFromCart(
                                            Provider.of<ProductProvider>(
                                                    context,
                                                    listen: false)
                                                .cartItems[index]['id']);
                                  },
                                  icon: const Icon(
                                    IconlyLight.delete,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      // Provider.of<WishListProvider>(context,
                                      //         listen: false)
                                      //     .addToWish(Provider.of<ProductProvider>(
                                      //             context,
                                      //             listen: false)
                                      //         .model[index]);
                                    },
                                    child: Icon(
                                        // Provider.of<WishListProvider>(context)
                                        //     .isProductInWish(
                                        //         Provider.of<ProductProvider>(context)
                                        //             .model[index])
                                        // ? Icons.favorite
                                        // :
                                        IconlyLight.heart)),
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

int? selectedQty;
