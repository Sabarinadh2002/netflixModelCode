import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({super.key, required this.index,required this.imageurl});
  final int index;
  final String imageurl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
              height: 200,
            ),
            Container(
              width: 130,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image:  DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                     imageurl,               
                     ),
              ),
            ),
            )
          ],
        ),
        Positioned(
          left: 10,
          bottom: -25,
          child: BorderedText(
            strokeColor: Colors.white,
            strokeWidth: 1.0,
            child: Text(
              "${index + 1}",
              style: TextStyle(
                  fontSize: 150,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  decorationColor: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
