import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../constant/assets_helper.dart';

class BannerBuilder extends StatelessWidget {
  const BannerBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: Swiper(
        physics: const ScrollPhysics(),
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            AssetsHelper.banners[index],
            fit: BoxFit.fill,
          );
        },
        itemCount: AssetsHelper.banners.length,
        pagination: const SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                color: Colors.white, activeColor: Colors.red)),
        // control: SwiperControl(),
      ),
    );
  }
}
