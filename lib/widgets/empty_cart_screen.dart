import 'package:flutter/material.dart';
import 'package:smart_shop/screens/search_screen.dart';
import 'package:smart_shop/widgets/title_text.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    super.key,
    required this.img,
    required this.pageName,
  });
  final String img;
  final String pageName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(img),
        const TitleText(
          label: 'Whoops',
          fontSize: 35,
          textColor: Colors.red,
        ),
        TitleText(
          label: 'your $pageName is empty',
          textColor: Colors.grey,
          fontSize: 15,
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            // Add your onPressed logic here
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Colors.blue), // Set the background color here
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const SearchScreen()));
            },
            child: TitleText(
              label: 'Shop Now',
              textColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        )
      ],
    );
  }
}
