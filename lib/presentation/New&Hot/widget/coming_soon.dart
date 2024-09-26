import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_2/core/colors/constants.dart';
import 'package:netflix_2/presentation/home/custom_button_widget.dart';
import 'package:netflix_2/presentation/widgets/video_widgets.dart';

class ComingsoonWidget extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String posterPath;
  final String movieName;
  final String description;
  const ComingsoonWidget({
    super.key,
    required this.id,
    required this.month,
    required this.day,
    required this.posterPath,
    required this.movieName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          height: 500,
          width: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(month, style: TextStyle(fontSize: 20, color: Colors.grey)),
              Text(
                day,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width - 50,
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoWidget(url: posterPath,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      movieName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 35,
                        letterSpacing: -3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                 const CoustomButtonWidget(
                    icon: Icons.remember_me,
                    title: "Remind me",
                    iconSize: 20,
                    textSize: 10,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                 const CoustomButtonWidget(
                    icon: Icons.info,
                    title: "Info ",
                    iconSize: 20,
                    textSize: 10,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
              kHeight,
              Text("Coming on $day $month"),
              kHeight,
              Text(
                movieName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              kHeight,
              Text(
                style: TextStyle(color: Colors.grey),
                description,
                maxLines: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
