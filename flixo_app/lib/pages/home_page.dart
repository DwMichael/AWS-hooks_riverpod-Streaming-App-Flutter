import 'package:flixo_app/widget/main_appbar.dart';
import 'package:flixo_app/widget/main_bottom_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routName = "/homepage";
  HomePage({required this.title, super.key});
  final String title;
  final List<Map> myProduct =
      List.generate(100, (index) => {"id": index, "name": "Product $index"});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: MainAppBar(),
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 120,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisExtent: 200),
          itemCount: myProduct.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              width: 50,
              color: Colors.red,
              child: Card(
                color: Colors.black,
                child: Center(
                    child: Text('Entry ${myProduct[index]}',
                        style: TextStyle(color: Colors.white))),
              ),
            );
          },
        ),
      ),
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
