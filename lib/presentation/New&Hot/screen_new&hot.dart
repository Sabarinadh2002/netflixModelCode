

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix_2/application/Hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_2/core/colors/constants.dart';
import 'package:netflix_2/presentation/New&Hot/widget/coming_soon.dart';
import 'package:netflix_2/presentation/New&Hot/widget/everyone_watching_widget.dart';


class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            title: const Text(
              "New & Hot",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
            actions: [
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
            ],
            bottom: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.white,
                labelColor: Colors.black,
                labelStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                tabs: [
                  Tab(
                    text: "🍿Comming soon",
                  ),
                  Tab(
                    text: "👀Everyone's watching",
                  ),
                ]),
          ),
        ),
        body: const TabBarView(
          children: [
             CommingSoonList(
              key: Key('coming_soon'),
            ),
            everyOneWatchingList(key: Key('Everyone is watching'),),
          ],
        ),
      ),
    );
  }
}
  
class CommingSoonList extends StatelessWidget {
  const CommingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const HotAndNewEvent.loadDataComingSoon());
    });
    return RefreshIndicator(
      onRefresh: ()async{
        BlocProvider.of<HotAndNewBloc>(context)
          .add(const HotAndNewEvent.loadDataComingSoon());
 
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isloading) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text("Error while loading coming soon list"),
            );
          } else if (state.comingSoonList.isEmpty) {
            return const Center(
              child: Text("Comming soon list is empty"),
            );
          } else {
            return ListView.builder(
                itemCount: state.comingSoonList.length,
                itemBuilder: (BuildContext context, index) {
                  final movie = state.comingSoonList[index];
                  if (movie.id == null) {
                    return const SizedBox();
                  }
                  String month = '';
                  String date = '';
                  try {
                    final _date = DateTime.tryParse(movie.releaseDate!);
                    final formatedDate = DateFormat.yMMMd('en_US').format(_date!);
      
                    month = formatedDate
                        .split(' ')
                        .first
                        .substring(0, 3)
                        .toUpperCase();
      
                    date = movie.releaseDate!.split('-')[1];
                  } catch (_) {
                    month = '';
                    date = '';
                  }
      
                  //print(formatedDate);
                  return ComingsoonWidget(
                    id: movie.id.toString(),
                    month: month,
                    day: date,
                    posterPath: '$imageAppendURL${movie.posterPath}',
                    movieName: movie.originalTitle ?? 'No title',
                    description: movie.overview ?? 'No Description',
                  );
                });
          }
        },
      ),
    );
  }
}


class everyOneWatchingList extends StatelessWidget {
  const everyOneWatchingList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const HotAndNewEvent.loadDataEveryoneIsWatching());
    });
    return RefreshIndicator(
      onRefresh: ()async{
        BlocProvider.of<HotAndNewBloc>(context)
          .add(const HotAndNewEvent.loadDataEveryoneIsWatching());
  
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isloading) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text("Error while loading coming soon list"),
            );
          } else if (state.everyOneWatchingList.isEmpty) {
            return const Center(
              child: Text("Comming soon list is empty"),
            );
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(20),
                itemCount: state.everyOneWatchingList.length,
                itemBuilder: (BuildContext context, index) {
                  final movie = state.everyOneWatchingList[index];
                  if (movie.id == null) {
                    return const SizedBox();
                  }
      
                  final tv = state.everyOneWatchingList[index];
      
                  return EveryoneWatching(
                    posterPath: '$imageAppendURL${tv.posterPath}',
                    movieName: tv.originalName??'No name provided',
                    description: tv.overview??'No description',
                  );
                });
          }
        },
      ),
    );
  }
}
