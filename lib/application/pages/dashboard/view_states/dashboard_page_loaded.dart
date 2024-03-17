import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class DashboardPageLoaded extends StatelessWidget {
  const DashboardPageLoaded({
    super.key,
    required this.uncompletedTasks,
  });

  final int uncompletedTasks;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'This is how many tasks you still have to do',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Shimmer(
                      color: Theme.of(context).colorScheme.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '$uncompletedTasks',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    (uncompletedTasks > 0)
                        ? 'Way to go, only a little bit left!'
                        : 'Add some more tasks or go celebrate!',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
