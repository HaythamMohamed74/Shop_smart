// import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:provider/provider.dart';
// import 'package:smart_shop/providers/wish_list_provider.dart';
// import 'package:smart_shop/widgets/title_text.dart';
//
// import '../providers/product_provider.dart';
//
// class CartWidget extends StatelessWidget {
//   const CartWidget({super.key, required this.index});
//   final int index;
//   @override
//   Widget build(BuildContext context) {
//     final product = Provider.of<ProductProvider>(
//       context,
//     ).model;
//     return FittedBox(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: IntrinsicWidth(
//           child: Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(25),
//                 child: Padding(
//                   padding: const EdgeInsets.all(2.0),
//                   child: FancyShimmerImage(
//                     imageUrl:
//                         // Provider.of<CartProvider>(context)
//                         //     .cart.values.toList()[ind
//                         // getCurrentProduct.productImg,
//                         Provider.of<ProductProvider>(context)
//                             .cart[index]
//                             .productImg,
//                     height: 120,
//                     width: 120,
//                   ),
//                 ),
//               ),
//               IntrinsicWidth(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: 200,
//                       child: TitleText(
//                         label: Provider.of<ProductProvider>(context)
//                             .cart[index]
//                             .productName,
//                         // getCurrentProduct.productName,
//                         maxLines: 2,
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                     Row(
//                       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         TitleText(
//                           // label: getCurrentProduct.productPrice,
//                           label:
//                               '\$${Provider.of<ProductProvider>(context).cart[index].productPrice}',
//                           textColor: Colors.grey,
//                         ),
//                         const SizedBox(
//                           width: 100,
//                         ),
//                         const SizedBox(width: 8),
//                         OutlinedButton.icon(
//                           onPressed: () async {
//                             // print('hh');
//                             showModalBottomSheet(
//                                 shape: const RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(20),
//                                         topRight: Radius.circular(20))),
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return Column(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Container(
//                                           height: 6,
//                                           width: 90,
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: ListView.builder(
//                                             physics:
//                                                 const NeverScrollableScrollPhysics(),
//                                             itemCount: 15,
//                                             itemBuilder: (BuildContext context,
//                                                 int index) {
//                                               return Center(
//                                                   child: GestureDetector(
//                                                 onTap: () {
//                                                   Provider.of<ProductProvider>(
//                                                           context,
//                                                           listen: false)
//                                                       .updateQuantity(
//                                                           productModel:
//                                                               Provider.of<ProductProvider>(
//                                                                       context,
//                                                                       listen:
//                                                                           false)
//                                                                   .model[index],
//                                                           quantity: index + 1);
//                                                 },
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(5.0),
//                                                   child: TitleText(
//                                                       label: '${index + 1}'),
//                                                 ),
//                                               ));
//                                             }),
//                                       ),
//                                     ],
//                                   );
//                                 });
//                           },
//                           icon: const Icon(IconlyLight.arrowDown2),
//                           label: GestureDetector(
//                             onTap: () {},
//                             child: TitleText(
//                               label: Provider.of<ProductProvider>(context)
//                                   .model[index]
//                                   .productQuantity,
//                               fontSize: 15,
//                             ),
//                           ),
//                           style: OutlinedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                             side: const BorderSide(color: Colors.blue),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         Provider.of<ProductProvider>(context, listen: false)
//                             .deleteFromCart(product[index]);
//                       },
//                       icon: const Icon(
//                         IconlyLight.delete,
//                       )),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   GestureDetector(
//                       onTap: () {
//                         Provider.of<WishListProvider>(context, listen: false)
//                             .addToWish(Provider.of<ProductProvider>(context,
//                                     listen: false)
//                                 .model[index]);
//                       },
//                       child: Icon(Provider.of<WishListProvider>(context)
//                               .isProductInWish(
//                                   Provider.of<ProductProvider>(context)
//                                       .model[index])
//                           ? Icons.favorite
//                           : IconlyLight.heart)),
//                   const SizedBox(height: 60),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
