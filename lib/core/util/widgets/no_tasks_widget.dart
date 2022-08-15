import 'package:flutter/material.dart';

class NoTasksWidget extends StatelessWidget {
  const NoTasksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'There are no tasks to display',
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey[500],
        ),
      ),
    );
  }
}
