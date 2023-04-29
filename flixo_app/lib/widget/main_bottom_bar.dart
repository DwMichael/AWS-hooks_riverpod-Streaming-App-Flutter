import 'package:flutter/material.dart';

import '../pages/main_pages/search_page.dart';

class MainBottomBar extends StatelessWidget {
  const MainBottomBar(
      {required this.isVisible, required this.isElevated, super.key});
  final bool isVisible;
  final bool isElevated;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isVisible ? 80.0 : 0,
      child: BottomAppBar(
        elevation: isElevated ? null : 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
                tooltip: 'Go to home page',
                icon: const Icon(Icons.home),
                onPressed: () {}),
            IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.routName);
              },
            ),
            IconButton(
              tooltip: 'Downloads',
              icon: const Icon(Icons.download),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'More',
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
