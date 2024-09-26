import 'package:flutter/material.dart';
import 'package:netflix_2/core/colors/constants.dart';
import 'package:netflix_2/presentation/home/custom_button_widget.dart';

class BackGroundWidget extends StatelessWidget {
  const BackGroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 600,
          decoration: const BoxDecoration(
            image: DecorationImage(image: NetworkImage(KmainImage)),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CoustomButtonWidget(
                  title: "My List",
                  icon: Icons.add,
                ),
                PlayButton(),
                const CoustomButtonWidget(
                  icon: Icons.info,
                  title: "Info",
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  TextButton PlayButton() {
    return TextButton.icon(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
      ),
      icon: Icon(
        Icons.play_arrow,
        size: 25,
        color: Colors.black,
      ),
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          "Play",
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
