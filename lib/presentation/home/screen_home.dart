import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_2/application/Home/home_bloc.dart';
import 'package:netflix_2/core/colors/constants.dart';
import 'package:netflix_2/presentation/home/background_card.dart';
import 'package:netflix_2/presentation/home/number_title_card.dart';
import 'package:netflix_2/presentation/widgets/main_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: scrollNotifier,
        builder: (BuildContext context, index, _) {
          return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final ScrollDirection direction = notification.direction;

                if (direction == ScrollDirection.reverse) {
                  scrollNotifier.value = false;
                } else if (direction == ScrollDirection.forward) {
                  scrollNotifier.value = true;
                }
                return true;
              },
              child: Stack(
                children: [
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {

                      if(state.isloading){
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        );
                      }
                      else if(state.hasError){
                        return Center(
                          child: Text(
                            "Error while getting data",
                            style: TextStyle(color: Colors.white),));
                      }
                      // released past year
                      final _releasedPastYear = state.pastyearMovieList.map((m){
                        return '$imageAppendURL${m.posterPath}';
                      }).toList();
                      _releasedPastYear.shuffle();
                      //trending
                      final _trending = state.trendingMovieList.map((m){
                        return '$imageAppendURL${m.posterPath}';
                      }).toList();
                      _trending.shuffle();
                      //tense drama
                      final _drama = state.tenseDramasMovieList.map((m){
                        return '$imageAppendURL${m.posterPath}';
                      }).toList();
                      //south indian movie list
                      final _southindianmovie = state.southIndianMovieList.map((m){
                        return '$imageAppendURL${m.posterPath}';
                      }).toList();
                      _southindianmovie.shuffle();
                      //top 10 tv shows
                      final _top10tvshow = state.trendingTVList.map((t){
                        return '$imageAppendURL${t.posterPath}';
                      }).toList();
                      _top10tvshow.shuffle();
                      


                      //list view
                      return ListView(
                        children:  [
                          BackGroundWidget(),
                          //
                          MainTitleCard(
                            title: "Realeased this year",
                            posterList: _releasedPastYear.sublist(0,10),
                          ),
                          kHeight,
                          MainTitleCard(
                            title: "Trending Now",
                            posterList: _trending.sublist(0,10),
                          ),
                          kHeight,

                          NumberTitleCard(
                            posterList: _top10tvshow.sublist(0,10),
                          ),
                          kHeight,
                          MainTitleCard(
                            title: "Tense Drama",
                            posterList: _drama.sublist(0,10),
                          ),
                          kHeight,
                          MainTitleCard(
                            title: "South Indian Cinema",
                            posterList: _southindianmovie.sublist(0,10),
                          ),
                          kHeight,
                        ],
                      );
                    },
                  ),
                  scrollNotifier.value == true
                      ? AnimatedContainer(
                          duration: const Duration(milliseconds: 1000),
                          width: double.infinity,
                          height: 90,
                          color: Colors.black.withOpacity(0.3),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzws4fg32F87LhX_hq5_T9p7Bik3JtIIVjVA&s",
                                    ),
                                    width: 70,
                                    height: 70,
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.cast,
                                    color: Colors.white,
                                  ),
                                  kWidth,
                                  Container(
                                    width: 30,
                                    height: 30,
                                    color: Colors.blue,
                                  ),
                                  kWidth,
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("TV shows ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  Text("Movie show",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  Text("Categories",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          ),
                        )
                      : kHeight,
                ],
              ));
        },
      ),
    );
  }
}
