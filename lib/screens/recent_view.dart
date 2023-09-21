import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../constant/assets_helper.dart';
import '../providers/recent_view.dart';
import '../widgets/empty_cart_screen.dart';
import '../widgets/title_text.dart';

class RecentView extends StatelessWidget {
  const RecentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final recntItems = Provider.of<RecentViewProvider>(context);
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
                label: ' recently viewed '
                    '(${(recntItems.recent.length)})')),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: recntItems.recent.isEmpty
          ? EmptyScreen(
              img: AssetsHelper.order,
              pageName: ' Recent view',
            )
          : DynamicHeightGridView(
              builder: (BuildContext context, int index) {
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FancyShimmerImage(
                        imageUrl: recntItems.recent[index].productImg,
                        // 'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png',
                        height: 170,
                        width: 170,
                        // boxDecoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: TitleText(
                            maxLines: 2,
                            label: recntItems.recent[index].productName,
                          ),
                        ),
                        Flexible(
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(IconlyLight.heart),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: TitleText(
                          label: '\$${recntItems.recent[index].productPrice}',
                          fontSize: 15,
                          textColor: Colors.blue,
                        )),
                        Flexible(
                          child: Container(
                            // width: 30,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.cyan),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add_shopping_cart_rounded,
                                size: 25,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
              itemCount: recntItems.recent.length,
              crossAxisCount: 2),
    );
  }
}
