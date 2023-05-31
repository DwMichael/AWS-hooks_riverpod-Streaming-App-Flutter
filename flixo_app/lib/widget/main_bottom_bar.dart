import 'package:flixo_app/pages/main_pages/download_page.dart';
import 'package:flixo_app/pages/main_pages/more_page.dart';
import 'package:flutter/material.dart';

import '../pages/main_pages/home_page.dart';
import '../pages/main_pages/search_page.dart';
import 'main_appbar.dart';

class MainBottomBar extends StatefulWidget {
  const MainBottomBar(
      {required this.isVisible, required this.isElevated, super.key});
  final bool isVisible;
  final bool isElevated;

  @override
  State<MainBottomBar> createState() => _MainBottomBarState();
}

class _MainBottomBarState extends State<MainBottomBar> {
  int _currentIndex = 0;
  final Map<int, Widget> _pages = {
    0: const HomePage(
      title: "Home Page",
    ),
    1: SearchPage(
      title: "Search Page",
    ),
    2: const DownLoadPage(),
    3: const MorePage(),
  };
  final bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: MainAppBar(),
      ),
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2D2D2D), Color(0xFF4A4A4A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: _pages[_currentIndex]),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: widget.isVisible ? 80.0 : 0,
        child: BottomNavigationBar(
          elevation: widget.isElevated ? null : 0.0,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Colors.grey),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
                backgroundColor: Colors.grey),
            BottomNavigationBarItem(
                icon: Icon(Icons.download),
                label: "Download",
                backgroundColor: Colors.grey),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: "More",
                backgroundColor: Colors.grey),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      floatingActionButton: isVisible
          ? FloatingActionButton(
              onPressed: () {},
              tooltip: 'Add New Item',
              elevation: true ? 10.0 : null,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
