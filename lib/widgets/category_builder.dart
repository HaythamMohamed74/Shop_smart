import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/assets_helper.dart';
import '../providers/product_provider.dart';
import '../screens/innerScreens/category_products.dart';

class CategoryBuilder extends StatelessWidget {
  const CategoryBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: DynamicHeightGridView(
        builder: (BuildContext context, int index) {
          return SizedBox(
            width: 85,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(0.2),
              child: GestureDetector(
                onTap: () async {
                  var selectedCategory = AssetsHelper.categoryNames[index];
                  await Provider.of<ProductProvider>(context, listen: false)
                      .fetchProductsByCategory(selectedCategory);
                  if (!context.mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryProduct(
                        selectedCategory: selectedCategory,
                      ),
                    ),
                  );
// //
                },
                child: Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset(AssetsHelper.category[index])),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Expanded(
                      child: Text(
                        AssetsHelper.categoryNames[index],
                        maxLines: 1,
                        // style: const TextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: AssetsHelper.category.length,
        crossAxisCount: 5,
      ),
    );
  }
}
