import 'package:flutter/material.dart';

class DashboardPageLoading extends StatelessWidget {
  const DashboardPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
