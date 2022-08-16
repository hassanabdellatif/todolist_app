import 'package:flutter/material.dart';
import 'package:todo_list_app/core/util/blocs/app/cubit.dart';

class LabelTextWidget extends StatelessWidget {
  final String label;
  const LabelTextWidget({
    Key? key,
    required this.label,
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
            color: AppCubit.get(context).isDark
                ? Colors.white
                : Colors.grey.shade800,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
