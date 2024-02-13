import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:azkar_notification/azkar/splash_view.dart';
import 'package:flutter/material.dart';

import '../constants/mycolors.dart';
import '../main.dart';

class NotificationServices {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'high_importance_channel',
          channelKey: 'high_importance_channel',
          channelName: 'Basic notification',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: MyColors.petrol,
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel_group',
          channelGroupName: 'Group 1',
        ),
      ],
      debug: true,
    );

    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
        onActionReceivedMethod: onActionReceivedMethod,
        onDismissActionReceivedMethod: onDismissActionReceivedMethod,
        onNotificationCreatedMethod: onNotificationCreatedMethod,
        onNotificationDisplayedMethod: onNotificationDisplayedMethod);
  }
  //  use this method to detect when a new notification or a schedule  is created

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');
  }
  //  use this method to detect every time that a new notification is display

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  //  use this method to detect if the user dismissed notification
  static Future<void> onDismissActionReceivedMethod(
      ReceivedNotification receivedAction) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  //  use this method to detect when the user taps on a notification or action button

  static Future<void> onActionReceivedMethod(
      ReceivedNotification receivedAction) async {
    debugPrint('onActionReceivedMethod');
    final payload = receivedAction.payload ?? {};
    if (payload["navigate" == "true"] != null) {
      NontificationApp.navigatorKey.currentState
          ?.push(MaterialPageRoute(builder: (_) => const SplashScreen()));
    }
  }

  static Future<void> showNotification({
    required final String title,
    required final String body,
    required int id,
    final String? channelKey,
    final String? summery,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
    final int? year,
    final int? month,
    final int? day,
    final int? hour,
    final int? minute,
    final int? second,
    required bool allowWhileIdle,
  }) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            channelKey: 'high_importance_channel',
            title: title,
            body: body,
            actionType: actionType,
            notificationLayout: notificationLayout,
            summary: summery,
            payload: payload,
            category: category,
            bigPicture: bigPicture),
        actionButtons: actionButtons,
        schedule: scheduled
            ? NotificationCalendar(
                year: year,
                day: day,
                hour: hour,
                minute: minute,
                second: second,
                timeZone:
                    await AwesomeNotifications().getLocalTimeZoneIdentifier(),
                repeats: false,
                allowWhileIdle: false,
              )
            : NotificationInterval(
                interval: interval,
                timeZone:
                    await AwesomeNotifications().getLocalTimeZoneIdentifier(),
                preciseAlarm: true));
  }
}
