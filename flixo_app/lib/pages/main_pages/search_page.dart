import 'package:flixo_app/widget/main_appbar.dart';
import 'package:flixo_app/widget/main_bottom_bar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  static const routName = "/searchpage";
  SearchPage({required this.title, super.key});
  final String title;
  final List<Map> myProduct2 =
      List.generate(5, (index) => {"id": index, "name": "Product $index"});
  final bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: MainAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 50,
                child: TextField(
                  autocorrect: true,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 10),
                      child: Column(
                        children: const <Widget>[
                          Icon(Icons.search),
                          Text(
                            "Search",
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    errorStyle: const TextStyle(fontSize: 0.01),
                    fillColor: const Color.fromRGBO(255, 255, 255, 1),
                    filled: true,
                  ),
                ),
              ),
            ),
            // GridView.builder(
            //     physics: const NeverScrollableScrollPhysics(),
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 3,
            //       mainAxisSpacing: 2,
            //       crossAxisSpacing: 2,
            //     ),
            //     itemCount: myProduct2.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return SizedBox(
            //         width: 100,
            //         height: 100,
            //         child: Card(
            //           color: Colors.black,
            //           child: ListTile(
            //             title: Text('Entry ${myProduct2[index][index]}',
            //                 style: const TextStyle(color: Colors.white)),
            //           ),
            //         ),
            //       );
            //     }),
          ],
        ),
      ),
      bottomNavigationBar: const MainBottomBar(
        isVisible: true,
        isElevated: true,
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
