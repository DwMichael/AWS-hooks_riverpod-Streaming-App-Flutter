import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    const double fontSize = 20;
    return AppBar(
      backgroundColor: Colors.black87,
      title: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("TV", style: TextStyle(fontSize: fontSize)),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Movies", style: TextStyle(fontSize: fontSize)),
            ),
            TextButton(
              onPressed: () {},
              child:
                  const Text("Favorites", style: TextStyle(fontSize: fontSize)),
            ),
          ],
        ),
      ),
    );
  }
}
