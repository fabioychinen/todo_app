import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ToDoEntryItemLoading extends StatelessWidget {
  const ToDoEntryItemLoading({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Shimmer(
        duration: const Duration(seconds: 2),
        color: Colors.grey,
        enabled: true,
        direction: const ShimmerDirection.fromLeftToRight(),
        child: const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
