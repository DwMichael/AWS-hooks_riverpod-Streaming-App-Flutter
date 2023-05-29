import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;

  StarRating({required this.rating});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    double starRating = rating / 2;
    if (index >= starRating) {
      icon = const Icon(
        Icons.star_border,
        color: Colors.grey,
      );
    } else if (index > starRating - 1 && index < starRating) {
      icon = Icon(
        Icons.star_half,
        color: Colors.yellow[800],
      );
    } else {
      icon = Icon(
        Icons.star,
        color: Colors.yellow[800],
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) => buildStar(context, index)),
    );
  }
}
