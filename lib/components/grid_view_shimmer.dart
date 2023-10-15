import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GridViewShimmer extends StatelessWidget {
  const GridViewShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade500,
      highlightColor: Colors.grey.shade300,
      child: Container(
        //constraints: const BoxConstraints(maxHeight: 500),
        padding: const EdgeInsets.all(16.0),
        height: 416, // You might want to adjust the height to your need
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(), // This disables scrolling
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 6 / 2, // Adjust aspect ratio to control the size of the tiles
            mainAxisSpacing: 16.0, // Vertical spacing
            crossAxisSpacing: 16.0, // Horizontal spacing
          ),
          itemBuilder: (BuildContext context, int index) {
            return GridTile(
              child: InkWell(
                onTap: () {},
                child: const Card(
                  color: Colors.grey,
                ),
              ),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
