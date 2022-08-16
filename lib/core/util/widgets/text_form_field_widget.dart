import 'package:flutter/material.dart';
import 'package:todo_list_app/core/util/blocs/app/cubit.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? validation;
  final String hintText;
  final TextInputType? type;
  final double width;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;

  const TextFormFieldWidget({
    super.key,
    required this.hintText,
    this.validation,
    this.type,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: SizedBox(
        width: width,
        height: 80,
        child: TextFormField(
          controller: controller,
          onTap: onTap,
          validator: (value) {
            if (value!.isEmpty) {
              return validation;
            }
            return null;
          },
          keyboardType: type,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            fillColor: AppCubit.get(context).isDark
                ? Colors.grey.shade200
                : Colors.grey.shade50,
          ),
        ),
      ),
    );
  }
}
