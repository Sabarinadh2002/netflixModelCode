import 'package:flutter/material.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottomnavigationWidget extends StatelessWidget {
  const BottomnavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexChangeNotifier,
      builder: (context, int newIndex, _) {
        return BottomNavigationBar(
          currentIndex: newIndex,
          onTap: (index) {
            indexChangeNotifier.value = index;
          },
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.collections,
                ),
                label: 'new & hot'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.emoji_emotions,
                ),
                label: 'Fast laugh'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.download,
                ),
                label: 'Downloads'),
          ],
        );
      },
    );
  }
}
