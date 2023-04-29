import 'package:flutter/material.dart';

class DownLoadPage extends StatefulWidget {
  static const routName = "/downl";
  const DownLoadPage({super.key});

  @override
  State<DownLoadPage> createState() => _DownLoadPageState();
}

class _DownLoadPageState extends State<DownLoadPage> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$_count"),
        IconButton(
          icon: Icon(Icons.abc),
          onPressed: () {
            setState(() {
              _count++;
            });
          },
        ),
      ],
    );
  }
}

// class name extends StatelessWidget {
//   const name({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
