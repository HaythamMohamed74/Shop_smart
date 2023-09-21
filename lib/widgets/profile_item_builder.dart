import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:smart_shop/widgets/title_text.dart';

class RowBuilder extends StatelessWidget {
  const RowBuilder(
      {super.key,
      required this.text,
      required this.img,
      required this.onPressed});
  final String text;
  final String img;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment,
        children: [
          Image.asset(
            img,
            width: 30,
          ),
          const SizedBox(
            width: 40,
          ),
          TitleText(
            label: text,
            fontSize: 15,
          ),
          const Spacer(),
          IconButton(
              icon: const Icon(IconlyLight.arrowRight2), onPressed: onPressed),
        ],
      ),
    );
  }
}
