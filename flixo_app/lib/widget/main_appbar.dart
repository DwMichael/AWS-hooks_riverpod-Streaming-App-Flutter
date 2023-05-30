import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black87,
      title: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 30,
              child: CircleAvatar(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    size: 15,
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
