import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/widgets/title_text.dart';

import '../providers/picked_image.dart';
import 'auth/elevated_icon_button.dart';

class CustomPickedImage extends StatelessWidget {
  const CustomPickedImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 2.0,
            ),
            image: Provider.of<PickedImage>(context).pickedImage != null
                ? DecorationImage(
                    image: FileImage(
                      Provider.of<PickedImage>(context).pickedImage!,
                    ),
                    fit: BoxFit.cover,
                  )
                : const DecorationImage(
                    image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
                    ),
                    fit: BoxFit.cover,
                  ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        Positioned(
            left: 55,
            bottom: 70,
            child: Container(
              // width: 30,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
              child: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          // scrollable: true,
                          backgroundColor: Colors.white,
                          content: SizedBox(
                            height: 160,
                            width: 120,
                            child: ListView(
                              children: [
                                const Center(
                                  child: TitleText(
                                    label: 'choose option',
                                  ),
                                ),
                                ElevatedIconButton(
                                    onPressed: () {
                                      Provider.of<PickedImage>(context,
                                              listen: false)
                                          .pickedImageFromCamera();
                                      // _pickImage();
                                      Navigator.pop(context);
                                    },
                                    icon: IconlyLight.camera,
                                    label: 'Camera'),
                                ElevatedIconButton(
                                    onPressed: () {
                                      Provider.of<PickedImage>(context,
                                              listen: false)
                                          .pickImageFromGallery();
                                      Navigator.pop(context);
                                    },
                                    icon: IconlyBroken.image,
                                    label: 'Gallery'),
                                ElevatedIconButton(
                                    onPressed: () {
                                      Provider.of<PickedImage>(context,
                                              listen: false)
                                          .deleteImage();
                                      Navigator.pop(context);
                                    },
                                    icon: IconlyLight.closeSquare,
                                    label: 'Remove')
                              ],
                            ),
                          ),
                        );
                      });
                },
                icon: const Icon(
                  IconlyLight.camera,
                  size: 20,
                ),
              ),
            ))
      ],
    );
  }
}
