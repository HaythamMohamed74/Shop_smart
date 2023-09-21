import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../constant/assets_helper.dart';
import '../providers/product_provider.dart';
import '../widgets/banner_build.dart';
import '../widgets/category_builder.dart';
import '../widgets/latest_arrival.dart';
import '../widgets/title_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: const TitleText(label: 'Shop smart')),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const BannerBuilder(),
            // Row(children: [],)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TitleText(label: 'Latest Arrival'),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      Provider.of<ProductProvider>(context).productsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ChangeNotifierProvider.value(
                      value: Provider.of<ProductProvider>(context)
                          .productsList[index],
                      child: LatestArrivalProductsWidget(
                        index: index,
                      ),
                    );
                  }),
            ),
            const Row(
              children: [
                TitleText(label: 'Categories'),
              ],
            ),
            const CategoryBuilder()
          ],
        ),
      ),
    );
  }
}
