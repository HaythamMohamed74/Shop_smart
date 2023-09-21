import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../constant/assets_helper.dart';
import '../models/product_model.dart';
import '../providers/product_provider.dart';
import '../providers/recent_view.dart';
import '../widgets/heart_button.dart';
import '../widgets/title_text.dart';
import 'innerScreens/details_screen.dart';

class SearchScreen extends StatefulWidget {
  final List<ProductModel>? productsByCategory;
  final String? selectedCategory;
  const SearchScreen({Key? key, this.productsByCategory, this.selectedCategory})
      : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose(); // Call dispose on the TextEditingController
    super.dispose();
  }

  final Stream<QuerySnapshot> productsStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ProductProvider>(context);
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
              label: widget.selectedCategory != null &&
                      widget.selectedCategory!.isNotEmpty
                  ? widget.selectedCategory!
                  : 'Search Screen',
            )),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: productsStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            final List<DocumentSnapshot> documents = snapshot.data?.docs ?? [];
            if (snapshot.hasError) {
              return Text('Something went wrong,${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }

            return Column(
              children: [
                widget.productsByCategory == null
                    ? TextFormField(
                        controller: controller,
                        onChanged: (query) {
                          setState(() {
                            // filteredDocuments = documents
                            //     .where((element) => element['productName']
                            //         .toString()
                            //         .toLowerCase()
                            //         .contains(query.toLowerCase()))
                            //     .toList();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                controller.clear();
                                // searchResults = [];
                              });
                              FocusScope.of(context).unfocus();
                            },
                            child: const Icon(Icons.clear),
                          ),

                          // child: const Icon(Icons.clear)
                        ))
                    : Text(''),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: DynamicHeightGridView(
                        itemCount: documents.length,
                        builder: (BuildContext context, int index) {
                          // final DocumentSnapshot document = filteredDocuments[index];
                          final DocumentSnapshot document = documents[index];
                          final Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;

                          ProductModel productModel =
                              ProductModel.fromFirestore(document);

                          return Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: GestureDetector(
                                  onTap: () {
                                    Provider.of<RecentViewProvider>(context,
                                            listen: false)
                                        .addToRecent(productModel);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) =>
                                            ChangeNotifierProvider.value(
                                          value: productModel,
                                          child: const DetailsScreen(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: FancyShimmerImage(
                                    imageUrl: data['image'],
                                    // product.productImg,
                                    height: 170,
                                    width: 170,
                                    // boxDecoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(20)),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: TitleText(
                                        maxLines: 2, label: data['productName']
                                        // product.productName
                                        ),
                                  ),
                                  Flexible(
                                      child: HeartButtonWidget(
                                    productId: productModel.productId,
                                  )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: TitleText(
                                    label: r'$'
                                        '${data['price']}',
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
                                          Provider.of<ProductProvider>(context,
                                                  listen: false)
                                              .addToCart(
                                                  image:
                                                      productModel.productImg,
                                                  name:
                                                      productModel.productName,
                                                  price:
                                                      productModel.productPrice,
                                                  productId:
                                                      productModel.productId);
                                        },
                                        child: Icon(
                                          Provider.of<ProductProvider>(context,
                                                      listen: false)
                                                  .isProductInCart(
                                                      productModel.productId)
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
            );
          }),
    );
  }
}
