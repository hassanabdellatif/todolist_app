import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class AwesomeNotificationsHelper {
  int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  void initialAwesomeNotifications() {
    AwesomeNotifications().initialize(
      'resource://drawable/res_notification_app_icon',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          defaultColor: Colors.teal,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          channelDescription: '',
        ),
        NotificationChannel(
          channelKey: 'scheduled_channel',
          channelName: 'Scheduled Notifications',
          defaultColor: Colors.teal,
          locked: true,
          importance: NotificationImportance.High,
          soundSource: 'resource://raw/res_custom_notification',
          channelDescription: '',
        ),
      ],
    );
  }

  Future<void> createTaskReminderNotification({
    int? timeOfDayHour,
    int? timeOfDayMinute,
    int? day,
    int? month,
    int? year,
    String? title,
    String? message,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'scheduled_channel',
        title: title,
        body: message,
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        day: day,
        month: month,
        year: year,
        hour: timeOfDayHour,
        minute: timeOfDayMinute,
        second: 0,
        millisecond: 0,
        repeats: true,
      ),
    );
  }

  Future<void> cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }

  Future<void> cancelScheduledNotificationsById(id) async {
    await AwesomeNotifications().cancelSchedule(id);
  }
}
