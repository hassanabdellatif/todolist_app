import 'package:flutter/material.dart';
import 'package:todo_list_app/core/util/blocs/app/app_cubit.dart';
import 'package:todo_list_app/core/util/constants/colors.dart';
import 'package:todo_list_app/core/util/widgets/label_text_widget.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({Key? key}) : super(key: key);

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextWidget(
          label: 'Pick a color:',
          color: AppCubit.get(context).isDark
              ? Colors.white
              : Colors.grey.shade800,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List<Widget>.generate(
            4,
            (index) => GestureDetector(
              onTap: () {
                setState(
                  () {
                    selectedColor = index;
                    AppCubit.get(context).colorController.text =
                        selectedColor.toString();
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ) +
                    const EdgeInsets.only(
                      top: 8,
                      bottom: 2,
                    ),
                child: CircleAvatar(
                  backgroundColor: index == 0
                      ? redColor
                      : index == 1
                          ? orangeColor
                          : index == 2
                              ? yellowColor
                              : blueColor,
                  radius: 16,
                  child: selectedColor == index
                      ? const Icon(Icons.done, color: Colors.white, size: 16)
                      : null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
