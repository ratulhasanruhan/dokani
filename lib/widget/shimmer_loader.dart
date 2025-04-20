import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmer() {
  return GridView.builder(
    itemCount: 10,  // Placeholder item count for shimmer
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.7,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
    ),
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [BoxShadow(blurRadius: 5.0, color: Colors.grey.withOpacity(0.2))],
          ),
        ),
      );
    },
  );
}
