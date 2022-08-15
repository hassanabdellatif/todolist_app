import 'package:flutter/material.dart';
import 'package:todo_list_app/core/util/constants/colors.dart';

class DefaultButtonWidget extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;
  final double width;
  final double height;
  final double radius;
  final VoidCallback onTap;
  const DefaultButtonWidget({
    Key? key,
    required this.text,
    this.buttonColor = greenColor,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 55,
    this.radius = 16,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            onPrimary: textColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
