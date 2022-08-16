import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/core/services/notifications/notification_services.dart';
import 'package:todo_list_app/core/util/blocs/app/cubit.dart';

void sendTaskNotification(
  BuildContext context, {
  var date,
  var myTime,
  int? year,
  int? month,
  int? day,
}) {
  date = DateFormat.jm().parse(AppCubit.get(context).endTimeController.text);
  year = int.parse(AppCubit.get(context).dateController.text.split('-')[0]);
  month = int.parse(AppCubit.get(context).dateController.text.split('-')[1]);
  day = int.parse(AppCubit.get(context).dateController.text.split('-')[2]);

  void scheduleTaskNotification({Duration? duration}) {
    myTime = DateFormat('HH:mm').format(date.subtract(duration));
    AwesomeNotificationsHelper().createTaskReminderNotification(
      timeOfDayHour: int.parse(myTime.toString().split(':')[0]),
      timeOfDayMinute: int.parse(myTime.toString().split(':')[1]),
      day: day,
      month: month,
      year: year,
      title: AppCubit.get(context).titleController.text,
      message: "Please complete the task before it expires.",
    );
  }

  if (AppCubit.get(context).remindController.text == '10 min before') {
    scheduleTaskNotification(
      duration: const Duration(minutes: 10),
    );
  } else if (AppCubit.get(context).remindController.text == '30 min before') {
    scheduleTaskNotification(
      duration: const Duration(minutes: 30),
    );
  } else if (AppCubit.get(context).remindController.text == '1 hour before') {
    scheduleTaskNotification(
      duration: const Duration(hours: 1),
    );
  } else if (AppCubit.get(context).remindController.text == '1 day before') {
    scheduleTaskNotification(
      duration: const Duration(days: 1),
    );
  }
}
