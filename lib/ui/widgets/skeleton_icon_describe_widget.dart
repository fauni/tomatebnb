import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonIconDescribeWidget extends StatelessWidget {
  const SkeletonIconDescribeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 30,
        height: 30, // Ajusta la altura según tus necesidades
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}