import 'package:flutter/cupertino.dart';

class Maincard extends StatelessWidget {
  final String imageurl;
  const Maincard({
    super.key,
    required this.imageurl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 130,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image:  DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
          imageurl,
          scale: 1.0,
          ),
        ),
      ),
    );
  }
}
