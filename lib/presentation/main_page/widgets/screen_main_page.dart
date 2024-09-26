import 'package:flutter/material.dart';

import 'package:netflix_2/presentation/New&Hot/screen_new&hot.dart';
import 'package:netflix_2/presentation/downloads/screen_downloads.dart';
import 'package:netflix_2/presentation/fast_laugh/screen_fast_laugh.dart';
import 'package:netflix_2/presentation/home/screen_home.dart';
import 'package:netflix_2/presentation/main_page/widgets/bottom_nav.dart';
import 'package:netflix_2/presentation/search/screen_search.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({super.key});

  final _pages = [
    ScreenHome(),
    ScreenFastLaugh(),
    ScreenSearch(),
    ScreenNewAndHot(),
    ScreenDownloads(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int index, _) {
            return _pages[index];
          },
        ),
      ),
      bottomNavigationBar: BottomnavigationWidget(),
    );
  }
}
