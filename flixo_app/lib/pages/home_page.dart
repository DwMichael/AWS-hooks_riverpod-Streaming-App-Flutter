import 'package:flixo_app/widget/main_bottom_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Witaj w home page"),
      ),
      body: const Center(),
      bottomNavigationBar: const MainBottomBar(
        isVisible: true,
        isElevated: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add New Item',
        elevation: true ? 0.0 : null,
        child: const Icon(Icons.add),
      ),
    );
  }
}
