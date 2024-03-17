import 'package:flutter/material.dart';

class DashboardPageError extends StatelessWidget {
  const DashboardPageError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: Text(
          'ERROR on the dashboard page, please try again later',
        ),
      ),
    );
  }
}
