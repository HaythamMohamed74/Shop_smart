import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_shop/constant/assets_helper.dart';
import 'package:smart_shop/screens/innerScreens/oreder_screen.dart';
import 'package:smart_shop/screens/recent_view.dart';
import 'package:smart_shop/widgets/title_text.dart';

import '../models/user_model.dart';
import '../providers/theme_providers.dart';
import '../providers/user_provider.dart';
import '../widgets/custom_alert_widget.dart';
import '../widgets/profile_item_builder.dart';
import 'innerScreens/wish_list.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final userProvider = Provider.of<UserProvider>(context);
    // var image = Provider.of<PickedImage>(context).pickedImage;
    return FutureBuilder<UserModel?>(
        future: userProvider.getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error loading user information${snapshot.error}'),
                ElevatedButton.icon(
                    onPressed: () async {
                      await alertDialogWidget(context);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    icon: const Icon(IconlyLight.logout),
                    label: const Text('logout'))
              ],
            ));
          } else if (!snapshot.hasData) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('User not authenticated'),
                Center(
                    child: ElevatedButton.icon(
                        onPressed: () async {
                          await alertDialogWidget(context);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        icon: const Icon(IconlyLight.logout),
                        label: const Text('logout')))
              ],
            ));
          } else {
            UserModel? userModel = snapshot.data!;
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
                      child: const TitleText(label: 'Profile screen')),
                  elevation: 0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                body: Column(
                  children: [
                    userModel.userImage == null
                        ? Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  width: 3),
                            ),
                            child: ClipOval(
                              child: FancyShimmerImage(
                                imageUrl:
                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
                                width: 40,
                                // 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
                              ),
                            )
                            //   ),
                            )
                        : Row(
                            children: [
                              Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).cardColor,
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        width: 3),
                                  ),
                                  child: ClipOval(
                                    child: FancyShimmerImage(
                                      imageUrl: userModel.userImage!,
                                      width: 40,
                                      // 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
                                    ),
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(userModel.name),
                                  TitleText(
                                    label: userModel.emailAddress,
                                    fontSize: 15,
                                  ),
                                ],
                              )
                            ],
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TitleText(label: 'General'),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RowBuilder(
                      text: 'All oreders',
                      img: AssetsHelper.order,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const OrderScreen()));
                      },
                    ),
                    RowBuilder(
                      text: 'Wishlist',
                      img: AssetsHelper.wishList,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const WishList()));
                      },
                    ),
                    RowBuilder(
                      text: 'Viewed recently',
                      img: AssetsHelper.viewRecent,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const RecentView()));
                      },
                    ),
                    RowBuilder(
                      text: 'Address',
                      img: AssetsHelper.location,
                      onPressed: () {},
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TitleText(label: 'Settings'),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment,
                        children: [
                          Image.asset(
                            AssetsHelper.theme,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          TitleText(
                            label: Provider.of<ThemeProvider>(
                              context,
                            ).isDarkTheme
                                ? 'Dark theme'
                                : 'Light theme',
                            fontSize: 15,
                          ),
                          // const Spacer(),
                          Flexible(
                            flex: 1,
                            child: SwitchListTile(
                                value: Provider.of<ThemeProvider>(context)
                                    .isDarkTheme,
                                onChanged: (value) {
                                  Provider.of<ThemeProvider>(context,
                                          listen: false)
                                      .setDarkTheme(valueTheme: value);
                                }),
                          ),
                        ],
                      ),
                    ),
                    Center(
                        child: ElevatedButton.icon(
                            onPressed: () async {
                              await alertDialogWidget(context);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            icon: const Icon(
                              IconlyLight.logout,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'logout',
                              style: TextStyle(color: Colors.white),
                            )))
                  ],
                ));

            // body: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Row(
            //       children: [
            //         Padding(
            //             padding: const EdgeInsets.all(5.0),
            //             child: userModel.userImage == null
            //                 ? Container(
            //                     width: 60,
            //                     height: 60,
            //                     decoration: BoxDecoration(
            //                       // shape: BoxShape.circle,
            //                       color: Theme.of(context).cardColor,
            //                       border: Border.all(
            //                           color: Theme.of(context)
            //                               .colorScheme
            //                               .background,
            //                           width: 3),
            //                     ),
            //                     child: ClipOval(
            //                       child: FancyShimmerImage(
            //                         imageUrl:
            //                             'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
            //                         width: 40,
            //                         // 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
            //                       ),
            //                     )
            //                     //   ),
            //                     )
            //                 : Container(
            //                     width: 60,
            //                     height: 60,
            //                     decoration: BoxDecoration(
            //                       shape: BoxShape.circle,
            //                       color: Theme.of(context).cardColor,
            //                       border: Border.all(
            //                           color: Theme.of(context)
            //                               .colorScheme
            //                               .background,
            //                           width: 3),
            //                     ),
            //                     child: ClipOval(
            //                       child: FancyShimmerImage(
            //                         imageUrl: userModel.userImage!,
            //                         width: 40,
            //                         // 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
            //                       ),
            //                     )
            //                     //   ),
            //                     )),
            //         const SizedBox(
            //           width: 5,
            //         ),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(userModel.name),
            //             TitleText(
            //               label: userModel.emailAddress,
            //               fontSize: 15,
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //     const SizedBox(
            //       height: 20,
            //     ),
            //     // const Expanded(
            //     //   child: Row(
            //     //     mainAxisAlignment: MainAxisAlignment.start,
            //     //     children: [
            //     //       TitleText(label: 'General'),
            //     //     ],
            //     //   ),
            //     // ),
            //     const SizedBox(
            //       height: 15,
            //     ),
            //     // Expanded(
            //     //   child: RowBuilder(
            //     //     text: 'All oreders',
            //     //     img: AssetsHelper.order,
            //     //     onPressed: () {},
            //     //   ),
            //     // ),
            //     // Expanded(
            //     //   child: RowBuilder(
            //     //     text: 'Wishlist',
            //     //     img: AssetsHelper.wishList,
            //     //     onPressed: () {
            //     //       Navigator.push(
            //     //           context,
            //     //           MaterialPageRoute(
            //     //               builder: (BuildContext context) =>
            //     //                   const WishList()));
            //     //     },
            //     //   ),
            //     // ),
            //     // RowBuilder(
            //     //   text: 'Viewed recently',
            //     //   img: AssetsHelper.viewRecent,
            //     //   onPressed: () {
            //     //     Navigator.push(
            //     //         context,
            //     //         MaterialPageRoute(
            //     //             builder: (BuildContext context) =>
            //     //                 const RecentView()));
            //     //   },
            //     // ),
            //     // RowBuilder(
            //     //   text: 'Address',
            //     //   img: AssetsHelper.location,
            //     //   onPressed: () {},
            //     // ),
            //     const Divider(
            //       thickness: 2,
            //     ),
            //
            //     Padding(
            //       padding: const EdgeInsets.all(5.0),
            //       child: Expanded(
            //         child: Row(
            //           // mainAxisAlignment: MainAxisAlignment,
            //           children: [
            //             Image.asset(
            //               AssetsHelper.theme,
            //               width: 30,
            //             ),
            //             const SizedBox(
            //               width: 40,
            //             ),
            //             TitleText(
            //               label: Provider.of<ThemeProvider>(
            //                 context,
            //               ).isDarkTheme
            //                   ? 'Dark theme'
            //                   : 'Light theme',
            //               fontSize: 15,
            //             ),
            //             const Spacer(),
            //             Expanded(
            //                 child: SwitchListTile(
            //                     value: Provider.of<ThemeProvider>(context)
            //                         .isDarkTheme,
            //                     onChanged: (value) {
            //                       Provider.of<ThemeProvider>(context,
            //                               listen: false)
            //                           .setDarkTheme(valueTheme: value);
            //                     })),
            //           ],
            //         ),
            //       ),
            //     ),
            //     const Divider(
            //       thickness: 2,
            //     ),
            //     Center(
            //         child: ElevatedButton.icon(
            //             onPressed: () async {
            //               await alertDialogWidget(context);
            //             },
            //             style: ButtonStyle(
            //                 backgroundColor:
            //                     MaterialStateProperty.all(Colors.red)),
            //             icon: const Icon(IconlyLight.logout),
            //             label: const Text('logout')))
            //   ],
            // ));
          }
        });
  }
}
