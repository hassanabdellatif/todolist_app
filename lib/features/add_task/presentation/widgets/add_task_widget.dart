import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/core/services/notifications/task_notification.dart';
import 'package:todo_list_app/core/util/blocs/app/cubit.dart';
import 'package:todo_list_app/core/util/widgets/default_button_widget.dart';
import 'package:todo_list_app/core/util/widgets/color_picker_widget.dart';
import 'package:todo_list_app/core/util/widgets/dropdown_widget.dart';
import 'package:todo_list_app/core/util/widgets/label_text_widget.dart';
import 'package:todo_list_app/core/util/widgets/text_form_field_widget.dart';

class AddTaskWidget extends StatelessWidget {
  const AddTaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final Color suffixIconColor =
    AppCubit.get(context).isDark ? Colors.grey.shade500 : Colors.grey;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        leading: BackButton(
          color: AppCubit.get(context).isDark
              ? Colors.white
              : Colors.grey.shade800,
        ),
        elevation: 0.5,
      ),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const LabelTextWidget(
                      label: 'Title:',
                    ),
                    TextFormFieldWidget(
                      controller: AppCubit.get(context).titleController,
                      type: TextInputType.text,
                      validation: "Title is required",
                      suffixIcon: Icon(
                        Icons.title_outlined,
                        color: suffixIconColor,
                      ),
                      hintText: 'Task Title',
                    ),
                    const LabelTextWidget(
                      label: 'Description:',
                    ),
                    TextFormFieldWidget(
                      controller: AppCubit.get(context).descriptionController,
                      type: TextInputType.text,
                      validation: "Description is required",
                      suffixIcon: Icon(
                        Icons.description_outlined,
                        color: suffixIconColor,
                      ),
                      hintText: 'Task Description',
                    ),
                    const LabelTextWidget(
                      label: 'Date:',
                    ),
                    TextFormFieldWidget(
                      controller: AppCubit.get(context).dateController,
                      type: TextInputType.none,
                      validation: "Date is required",
                      suffixIcon: Icon(
                        Icons.calendar_today_outlined,
                        color: suffixIconColor,
                      ),
                      hintText: "Task Date",
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.parse('2022-12-31'),
                        ).then(
                          (value) {
                            AppCubit.get(context).dateController.text =
                                DateFormat('yyyy-MM-dd')
                                    .format(value!)
                                    .toString();
                          },
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const LabelTextWidget(
                              label: 'Start Time:',
                            ),
                            TextFormFieldWidget(
                              width: 145,
                              controller:
                                  AppCubit.get(context).startTimeController,
                              type: TextInputType.none,
                              validation: "Start Time is required",
                              suffixIcon: Icon(
                                Icons.watch_later_outlined,
                                color: suffixIconColor,
                              ),
                              hintText: "Start time",
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then(
                                  (value) {
                                    AppCubit.get(context)
                                            .startTimeController
                                            .text =
                                        value!.format(context).toString();
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const LabelTextWidget(
                              label: 'End Time:',
                            ),
                            TextFormFieldWidget(
                              width: 145,
                              controller:
                                  AppCubit.get(context).endTimeController,
                              type: TextInputType.none,
                              validation: "End Time is required",
                              suffixIcon: Icon(
                                Icons.watch_later_outlined,
                                color: suffixIconColor,
                              ),
                              hintText: "End time",
                              onTap: () {
                                if (AppCubit.get(context)
                                    .startTimeController
                                    .text
                                    .isEmpty) {
                                  Fluttertoast.showToast(
                                    msg:
                                        "Please enter the start time first before the end time.",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                  );
                                } else {
                                  showTimePicker(
                                    context: context,
                                    // initialTime: TimeOfDay.now(),
                                    initialTime: TimeOfDay.now(),
                                  ).then(
                                    (value) {
                                      AppCubit.get(context)
                                              .endTimeController
                                              .text =
                                          value!.format(context).toString();
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const LabelTextWidget(
                      label: 'Remind:',
                    ),
                    TextFormFieldWidget(
                      controller: AppCubit.get(context).remindController,
                      validation: "Remind is required",
                      type: TextInputType.none,
                      suffixIcon: DropdownButtonWidget(
                        itemList: AppCubit.get(context).remindList,
                        selectedValue: AppCubit.get(context).selectedRemind,
                        controller: AppCubit.get(context).remindController,
                      ),
                      hintText: AppCubit.get(context).selectedRemind,
                    ),
                    const ColorPickerWidget(),
                    const SizedBox(height: 10),
                    DefaultButtonWidget(
                      text: 'Create a task',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          AppCubit.get(context).insertTaskData();
                          sendTaskNotification(context);
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/board_page',
                            (route) => false,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
