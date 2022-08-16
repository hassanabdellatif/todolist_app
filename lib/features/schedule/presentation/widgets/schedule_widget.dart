import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/core/util/blocs/app/cubit.dart';
import 'package:todo_list_app/core/util/constants/colors.dart';
import 'package:todo_list_app/core/util/constants/strings.dart';
import 'package:todo_list_app/features/schedule/presentation/widgets/schedule_listview.dart';

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({Key? key}) : super(key: key);

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule"),
        leading: BackButton(
          color: AppCubit.get(context).isDark
              ? Colors.white
              : Colors.grey.shade800,
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 16, left: 8),
            child: DatePicker(
              DateTime.now(),
              width: 49,
              height: 77,
              initialSelectedDate: DateTime.now(),
              selectionColor: greenColor,
              monthTextStyle: TextStyle(
                color: AppCubit.get(context).isDark
                    ? Colors.grey
                    : Colors.grey.shade600,
              ),
              dayTextStyle: TextStyle(
                color: AppCubit.get(context).isDark
                    ? Colors.grey
                    : Colors.grey.shade600,
              ),
              selectedTextColor: AppCubit.get(context).isDark
                  ? Colors.white
                  : Colors.grey.shade800,
              dateTextStyle: TextStyle(
                color: AppCubit.get(context).isDark
                    ? Colors.grey
                    : Colors.grey.shade600,
              ),
              onDateChange: (newDate) {
                setState(
                  () {
                    selectedDate = newDate;
                    datetime = DateFormat('yyyy-MM-dd').format(newDate);
                  },
                );
              },
            ),
          ),
          Divider(
              color: AppCubit.get(context).isDark
                  ? Colors.grey.shade900
                  : Colors.grey,
              height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.EEEE().format(selectedDate).toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppCubit.get(context).isDark
                        ? Colors.white
                        : Colors.grey.shade800,
                  ),
                ),
                Text(
                  DateFormat('d MMM, yyyy').format(selectedDate).toString(),
                  style: TextStyle(
                    color: AppCubit.get(context).isDark
                        ? Colors.white
                        : Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 500,
            child: ScheduleListView(),
          ),
        ],
      ),
    );
  }
}
