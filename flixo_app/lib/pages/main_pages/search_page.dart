import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  static const routName = "/searchpage";
  SearchPage({required this.title, super.key});
  final String title;
  final List<Map> myProduct2 =
      List.generate(20, (index) => {"id": index, "name": "Product $index"});
  final bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 50,
              child: TextField(
                autocorrect: true,
                decoration: InputDecoration(
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(top: 5.0, left: 10),
                    child: Column(
                      children: <Widget>[
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[Text("FILTR")],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 5,
                  mainAxisExtent: 300),
              shrinkWrap: true,
              itemCount: myProduct2.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.black,
                  child: ListTile(
                    title: Text('Entry ${myProduct2[index][index]}',
                        style: const TextStyle(color: Colors.white)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
