import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/util/blocs/app/cubit.dart';

class CheckBoxWidget extends StatefulWidget {
  final double radius;
  final Color unselectedWidgetColor;
  final Color activeColor;
  final int id;
  final String status;
  const CheckBoxWidget({
    required this.status,
    Key? key,
    required this.radius,
    required this.unselectedWidgetColor,
    required this.activeColor,
    required this.id,
  }) : super(key: key);

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        bool isChecked = (widget.status == 'completed') ? true : false;
        return Theme(
          data: ThemeData(
            unselectedWidgetColor: widget.unselectedWidgetColor,
          ),
          child: Checkbox(
            value: isChecked,
            activeColor: widget.activeColor,
            checkColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            onChanged: (value) {
              setState(
                () {
                  isChecked = value!;
                  if (isChecked) {
                    AppCubit.get(context).updateTaskStatus(
                      status: 'completed',
                      id: widget.id,
                    );
                  } else {
                    AppCubit.get(context).updateTaskStatus(
                      status: 'uncompleted',
                      id: widget.id,
                    );
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
