// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo_list_app/core/util/blocs/app/cubit.dart';

class DropdownButtonWidget extends StatefulWidget {
  final List<String> itemList;
  final TextEditingController controller;

  String selectedValue;
  DropdownButtonWidget({
    Key? key,
    required this.itemList,
    required this.selectedValue,
    required this.controller,
  }) : super(key: key);

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      icon: Padding(
        padding: const EdgeInsets.only(right: 14),
        child: Icon(
          Icons.keyboard_arrow_down,
          color:
              AppCubit.get(context).isDark ? Colors.grey.shade500 : Colors.grey,
        ),
      ),
      items: widget.itemList.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(
            items,
            style: const TextStyle(color: Colors.grey),
          ),
        );
      }).toList(),
      underline: Container(),
      onChanged: (String? newValue) {
        setState(
          () {
            widget.selectedValue = newValue!;
            widget.controller.text = widget.selectedValue.toString();
          },
        );
      },
    );
  }
}
