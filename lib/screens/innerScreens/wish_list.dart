import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_shop/providers/wish_list_provider.dart';

import '../../constant/assets_helper.dart';
import '../../widgets/empty_cart_screen.dart';
import '../../widgets/product_widget.dart';
import '../../widgets/title_text.dart';

class WishList extends StatelessWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
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
            child: const TitleText(label: 'wishList')),
        // child: TitleText(
        //     label: 'Wish List '
        //         '(${(Provider.of<WishListProvider>(context).wishProduct.length)})')),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: wishlistProvider.getWishlistItems.isEmpty
          ? Center(
              child: EmptyScreen(
                img: AssetsHelper.order,
                pageName: 'Wish list',
              ),
            )
          : DynamicHeightGridView(
              itemCount: wishlistProvider.getWishlistItems.length,
              builder: (BuildContext context, int index) {
                // final wishList = Provider.of<ProductProvider>(context).wishList;
                return ProductWidget(
                  productId: wishlistProvider.getWishlistItems.values
                      .toList()[index]
                      .productId,
                );
              },
              // itemCount: 2,
              // Provider.of<WishListProvider>(context).wishProduct.length,
              crossAxisCount: 2),
    );
  }
}
