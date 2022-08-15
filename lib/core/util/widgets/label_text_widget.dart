import 'package:flutter/material.dart';

class LabelTextWidget extends StatelessWidget {
  final String label;
  final Color color;
  const LabelTextWidget({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
