import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_2/core/colors/constants.dart';
import 'package:netflix_2/presentation/home/custom_button_widget.dart';
import 'package:netflix_2/presentation/widgets/video_widgets.dart';

class EveryoneWatching extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String description;
  const EveryoneWatching({
    super.key,
    required this.posterPath,
    required this.movieName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kHeight,
        Text(
          movieName,
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        kHeight,
        Text(
          style: TextStyle(color: Colors.grey),
          description,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 50,
        ),
        VideoWidget(
          url: posterPath,
        ),
        kHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            CoustomButtonWidget(
              icon: Icons.share,
              title: "Share",
              iconSize: 25,
              textSize: 16,
            ),
            kWidth,
            CoustomButtonWidget(
              icon: Icons.add,
              title: "My List",
              iconSize: 25,
              textSize: 16,
            ),
            kWidth,
            CoustomButtonWidget(
              icon: Icons.play_arrow,
              title: "Play",
              iconSize: 25,
              textSize: 16,
            ),
            kWidth,
          ],
        )
      ],
    );
  }
}
