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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'Flixo',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w100,
                  color: Colors.white),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
            ),
            SizedBox(
              height: 30,
              child: CircleAvatar(
                  child: Image.asset(
                'assets/image/cat.png',
                fit: BoxFit.fill,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
