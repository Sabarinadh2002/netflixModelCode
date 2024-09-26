import 'package:flutter/material.dart';
import 'package:netflix_2/core/colors/constants.dart';
import 'package:netflix_2/presentation/home/number_card.dart';
import 'package:netflix_2/presentation/widgets/main_title.dart';

class NumberTitleCard extends StatelessWidget {
  const NumberTitleCard({
    super.key,
    required this.posterList,
  });

  final List<String> posterList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(title: "Top 10 TV series in india today"),
        kHeight,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              posterList.length,
                
                (index) => NumberCard(
                      index: index,
                      imageurl: posterList[index],
                    )),
          ),
        )
      ],
    );
  }
}
