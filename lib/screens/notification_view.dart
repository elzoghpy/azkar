// ignore_for_file: non_constant_identifier_names

import 'package:adhan/adhan.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:azkar_notification/constants/app_striengs.dart';
import 'package:azkar_notification/constants/assets.dart';
import 'package:azkar_notification/constants/lists/listes.dart';
import 'package:azkar_notification/constants/mycolors.dart';
import 'package:azkar_notification/models/azkar_model.dart';
import 'package:azkar_notification/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart' as intl;

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

bool isSwitched = false;
int selectedEndTimeIndex = 0; // Default index for end time
int selectedIntervalIndex = 0; // Default index for interval
DateTime selectedDateTime = DateTime(
    DateTime.now().year, DateTime.now().month, DateTime.now().day, 19, 0);
List<String> endTimes = EndTimes;
List<String> intervals = Intervals;
List<int> repeatingNotificationIdsmorning = [];
List<int> repeatingNotificationIdsnight = [];
List<int> repeatingNotificationIdssalah = [];
List<int> repeatingNotificationIdsaftersalah = [];
List<int> repeatingNotificationIdssleep = [];
List<int> notificationIdsmorning = [];
List<int> notificationIdsnight = [];
List<int> notificationIds = [];
List<String> NightList = nightList;
List<String> AfterSalahList = aftersalahList;
List<String> SleepList = sleeplist;
List<String> MorningList = morningList;
const String boxnight = 'night_model_box';
const String boxaftersalah = 'aftersalah_model_box';
const String boxsalah = 'salah_model_box';
const String boxsleep = 'sleep_model_box';
const String boxmorning = 'morning_model_box';

Future<void> saveSettingsMorning() async {
  final box = await Hive.openBox<MorningModel>(boxmorning);
  final morningModel = MorningModel(
    endTime: selectedEndTimeIndex,
    intervalTime: selectedIntervalIndex,
    startTime: selectedDateTime,
    isAllowed: isSwitched,
  );
  await box.put('settings', morningModel);
}

Future<void> saveSettingsSleep() async {
  final box = await Hive.openBox<NightModel>(boxsleep);
  final sleepModel = NightModel(
    endTime: selectedEndTimeIndex,
    intervalTime: selectedIntervalIndex,
    startTime: selectedDateTime,
    isAllowed: isSwitched,
  );
  await box.put('settings', sleepModel);
}

Future<void> saveSettingsNight() async {
  final box = await Hive.openBox<NightModel>(boxnight);
  final nightmodel = NightModel(
    endTime: selectedEndTimeIndex,
    intervalTime: selectedIntervalIndex,
    startTime: selectedDateTime,
    isAllowed: isSwitched,
  );
  await box.put('settings', nightmodel);
}

Future<void> saveSettingsAfterSalah() async {
  final box = await Hive.openBox<AfterSalahModel>(boxaftersalah);
  final afterSalahModel = AfterSalahModel(
    endTime: selectedEndTimeIndex,
    intervalTime: selectedIntervalIndex,
    startTime: selectedDateTime,
    isAllowed: isSwitched,
  );
  await box.put('settings', afterSalahModel);
}

Future<void> saveSettingsSalah() async {
  final box = await Hive.openBox<SalahModel>(boxsalah);
  final salahModel = SalahModel(
    endTime: selectedEndTimeIndex,
    intervalTime: selectedIntervalIndex,
    startTime: selectedDateTime,
    isAllowed: isSwitched,
  );
  await box.put('settings', salahModel);
}

void scheduleRepeatingNotificationNight(
  List<String> NightList,
  int selectedEndTimeIndex,
  int selectedIntervalIndex,
) async {
  String localTimeZone =
      await AwesomeNotifications().getLocalTimeZoneIdentifier();

  // Check if notifications are already scheduled
  if (repeatingNotificationIdsnight.isNotEmpty) {
    // Cancel existing notifications
    for (int notificationId in repeatingNotificationIdsnight) {
      AwesomeNotifications().cancelSchedule(notificationId);
    }
  }

  DateTime notificationStartTime = DateTime(
    selectedDateTime.year,
    selectedDateTime.month,
    selectedDateTime.day,
    selectedDateTime.hour,
    selectedDateTime.minute,
  );

  // Calculate the end time based on the selected option
  DateTime notificationEndTime;
  switch (selectedEndTimeIndex) {
    case 0: // 1 hour
      notificationEndTime = notificationStartTime.add(const Duration(hours: 1));
      break;
    case 1: // 2 hours
      notificationEndTime = notificationStartTime.add(const Duration(hours: 2));
      break;
    case 2: // 3 hours
      notificationEndTime = notificationStartTime.add(const Duration(hours: 3));
      break;
    default:
      // Default to 1 hour
      notificationEndTime = notificationStartTime.add(const Duration(hours: 1));
      break;
  }

  // Calculate the time difference between start and end times
  Duration timeDifference =
      notificationEndTime.difference(notificationStartTime);

  // Calculate the interval duration based on the selected option
  int intervalInMinutes;
  switch (selectedIntervalIndex) {
    case 0: // 1 minute
      intervalInMinutes = 1;
      break;
    case 1: // 5 minutes
      intervalInMinutes = 5;
      break;
    case 2: // 10 minutes
      intervalInMinutes = 10;
      break;
    default:
      // Default to 1 minute
      intervalInMinutes = 1;
      break;
  }

  // Calculate the number of intervals based on the selected option
  int intervals = timeDifference.inMinutes ~/ intervalInMinutes;

  // Schedule notifications with the selected interval
  for (int i = 0; i < intervals && i < NightList.length; i++) {
    DateTime scheduledTime =
        notificationStartTime.add(Duration(minutes: i * intervalInMinutes));

    int notificationId = i + 1;
    repeatingNotificationIdsnight.add(notificationId);

    await NotificationServices.showNotification(
      id: notificationId,
      channelKey: 'basic_channel',
      title: 'أذكار المساء',
      body: NightList[i], // Use the body from the list
      scheduled: true,
      year: scheduledTime.year,
      month: scheduledTime.month,
      day: scheduledTime.day,
      hour: scheduledTime.hour,
      minute: scheduledTime.minute,
      second: 0,
      allowWhileIdle: true,
    );

    debugPrint(localTimeZone);
    debugPrint(scheduledTime.year.toString());
    debugPrint(scheduledTime.month.toString());
    debugPrint(scheduledTime.day.toString());
    debugPrint(scheduledTime.hour.toString());
    debugPrint(scheduledTime.minute.toString());
  }
  // Save the settings whenever the switch is changed
  saveSettingsNight();
}

void scheduleRepeatingNotificationAfterSalah(
  List<String> AfterSalahList,
  int selectedEndTimeIndex,
  int selectedIntervalIndex,
) async {
  String localTimeZone =
      await AwesomeNotifications().getLocalTimeZoneIdentifier();

  // Check if notifications are already scheduled
  if (repeatingNotificationIdsaftersalah.isNotEmpty) {
    // Cancel existing notifications
    for (int notificationId in repeatingNotificationIdsaftersalah) {
      AwesomeNotifications().cancelSchedule(notificationId);
    }
  }

  DateTime notificationStartTime = DateTime(
    selectedDateTime.year,
    selectedDateTime.month,
    selectedDateTime.day,
    selectedDateTime.hour,
    selectedDateTime.minute,
  );

  // Calculate the end time based on the selected option
  DateTime notificationEndTime;
  switch (selectedEndTimeIndex) {
    case 0: // 1 hour
      notificationEndTime = notificationStartTime.add(const Duration(hours: 1));
      break;
    case 1: // 2 hours
      notificationEndTime = notificationStartTime.add(const Duration(hours: 2));
      break;
    case 2: // 3 hours
      notificationEndTime = notificationStartTime.add(const Duration(hours: 3));
      break;
    default:
      // Default to 1 hour
      notificationEndTime = notificationStartTime.add(const Duration(hours: 1));
      break;
  }

  // Calculate the time difference between start and end times
  Duration timeDifference =
      notificationEndTime.difference(notificationStartTime);

  // Calculate the interval duration based on the selected option
  int intervalInMinutes;
  switch (selectedIntervalIndex) {
    case 0: // 1 minute
      intervalInMinutes = 1;
      break;
    case 1: // 5 minutes
      intervalInMinutes = 5;
      break;
    case 2: // 10 minutes
      intervalInMinutes = 10;
      break;
    default:
      // Default to 1 minute
      intervalInMinutes = 1;
      break;
  }

  // Calculate the number of intervals based on the selected option
  int intervals = timeDifference.inMinutes ~/ intervalInMinutes;

  // Schedule notifications with the selected interval
  for (int i = 0; i < intervals && i < AfterSalahList.length; i++) {
    DateTime scheduledTime =
        notificationStartTime.add(Duration(minutes: i * intervalInMinutes));

    int notificationId = i + 1;
    repeatingNotificationIdsaftersalah.add(notificationId);

    await NotificationServices.showNotification(
      id: notificationId,
      channelKey: 'basic_channel',
      title: 'أذكار بعد الصلاة',
      body: AfterSalahList[i], // Use the body from the list
      scheduled: true,
      year: scheduledTime.year,
      month: scheduledTime.month,
      day: scheduledTime.day,
      hour: scheduledTime.hour,
      minute: scheduledTime.minute,
      second: 0,
      allowWhileIdle: true,
    );

    debugPrint(localTimeZone);
    debugPrint(scheduledTime.year.toString());
    debugPrint(scheduledTime.month.toString());
    debugPrint(scheduledTime.day.toString());
    debugPrint(scheduledTime.hour.toString());
    debugPrint(scheduledTime.minute.toString());
  }
  // Save the settings whenever the switch is changed
  saveSettingsAfterSalah();
}

void scheduleRepeatingNotificationSalah(
  List<String> TitelSalahList,
  List<String> SubTitleSalahlList,
  int selectedEndTimeIndex,
  int selectedIntervalIndex,
) async {
  String localTimeZone =
      await AwesomeNotifications().getLocalTimeZoneIdentifier();

  // Check if notifications are already scheduled
  if (repeatingNotificationIdssalah.isNotEmpty) {
    // Cancel existing notifications
    for (int notificationId in repeatingNotificationIdssalah) {
      AwesomeNotifications().cancelSchedule(notificationId);
    }
  }

  DateTime notificationStartTime = DateTime(
    selectedDateTime.year,
    selectedDateTime.month,
    selectedDateTime.day,
    selectedDateTime.hour,
    selectedDateTime.minute,
  );

  // Calculate the end time based on the selected option
  DateTime notificationEndTime;
  switch (selectedEndTimeIndex) {
    case 0: // 1 hour
      notificationEndTime = notificationStartTime.add(const Duration(hours: 1));
      break;
    case 1: // 2 hours
      notificationEndTime = notificationStartTime.add(const Duration(hours: 2));
      break;
    case 2: // 3 hours
      notificationEndTime = notificationStartTime.add(const Duration(hours: 3));
      break;
    default:
      // Default to 1 hour
      notificationEndTime = notificationStartTime.add(const Duration(hours: 1));
      break;
  }

  // Calculate the time difference between start and end times
  Duration timeDifference =
      notificationEndTime.difference(notificationStartTime);

  // Calculate the interval duration based on the selected option
  int intervalInMinutes;
  switch (selectedIntervalIndex) {
    case 0: // 1 minute
      intervalInMinutes = 1;
      break;
    case 1: // 5 minutes
      intervalInMinutes = 5;
      break;
    case 2: // 10 minutes
      intervalInMinutes = 10;
      break;
    default:
      // Default to 1 minute
      intervalInMinutes = 1;
      break;
  }

  // Calculate the number of intervals based on the selected option
  int intervals = timeDifference.inMinutes ~/ intervalInMinutes;

  // Schedule notifications with the selected interval
  for (int i = 0; i < intervals && i < TitelSalahList.length; i++) {
    DateTime scheduledTime =
        notificationStartTime.add(Duration(minutes: i * intervalInMinutes));

    int notificationId = i + 1;
    repeatingNotificationIdssalah.add(notificationId);

    await NotificationServices.showNotification(
      id: notificationId,
      channelKey: 'basic_channel',
      title: 'أذكار الصلاة',
      body: TitelSalahList[i], // Use the body from the list
      scheduled: true,
      year: scheduledTime.year,
      month: scheduledTime.month,
      day: scheduledTime.day,
      hour: scheduledTime.hour,
      minute: scheduledTime.minute,
      second: 0,
      allowWhileIdle: true,
    );

    debugPrint(localTimeZone);
    debugPrint(scheduledTime.year.toString());
    debugPrint(scheduledTime.month.toString());
    debugPrint(scheduledTime.day.toString());
    debugPrint(scheduledTime.hour.toString());
    debugPrint(scheduledTime.minute.toString());
  }
  // Save the settings whenever the switch is changed
  saveSettingsSalah();
}

void scheduleRepeatingNotificationSleep(
  List<String> SleepList,
  int selectedEndTimeIndex,
  int selectedIntervalIndex,
) async {
  String localTimeZone =
      await AwesomeNotifications().getLocalTimeZoneIdentifier();

  // Check if notifications are already scheduled
  if (repeatingNotificationIdssleep.isNotEmpty) {
    // Cancel existing notifications
    for (int notificationId in repeatingNotificationIdssleep) {
      AwesomeNotifications().cancelSchedule(notificationId);
    }
  }

  DateTime notificationStartTime = DateTime(
    selectedDateTime.year,
    selectedDateTime.month,
    selectedDateTime.day,
    selectedDateTime.hour,
    selectedDateTime.minute,
  );

  // Calculate the end time based on the selected option
  DateTime notificationEndTime;
  switch (selectedEndTimeIndex) {
    case 0: // 1 hour
      notificationEndTime = notificationStartTime.add(const Duration(hours: 1));
      break;
    case 1: // 2 hours
      notificationEndTime = notificationStartTime.add(const Duration(hours: 2));
      break;
    case 2: // 3 hours
      notificationEndTime = notificationStartTime.add(const Duration(hours: 3));
      break;
    default:
      // Default to 1 hour
      notificationEndTime = notificationStartTime.add(const Duration(hours: 1));
      break;
  }

  // Calculate the time difference between start and end times
  Duration timeDifference =
      notificationEndTime.difference(notificationStartTime);

  // Calculate the interval duration based on the selected option
  int intervalInMinutes;
  switch (selectedIntervalIndex) {
    case 0: // 1 minute
      intervalInMinutes = 1;
      break;
    case 1: // 5 minutes
      intervalInMinutes = 5;
      break;
    case 2: // 10 minutes
      intervalInMinutes = 10;
      break;
    default:
      // Default to 1 minute
      intervalInMinutes = 1;
      break;
  }

  // Calculate the number of intervals based on the selected option
  int intervals = timeDifference.inMinutes ~/ intervalInMinutes;

  // Schedule notifications with the selected interval
  for (int i = 0; i < intervals && i < SleepList.length; i++) {
    DateTime scheduledTime =
        notificationStartTime.add(Duration(minutes: i * intervalInMinutes));

    int notificationId = i + 1;
    repeatingNotificationIdssleep.add(notificationId);

    await NotificationServices.showNotification(
      id: notificationId,
      channelKey: 'basic_channel',
      title: 'أذكار المساء',
      body: SleepList[i], // Use the body from the list
      scheduled: true,
      year: scheduledTime.year,
      month: scheduledTime.month,
      day: scheduledTime.day,
      hour: scheduledTime.hour,
      minute: scheduledTime.minute,
      second: 0,
      allowWhileIdle: true,
    );

    debugPrint(localTimeZone);
    debugPrint(scheduledTime.year.toString());
    debugPrint(scheduledTime.month.toString());
    debugPrint(scheduledTime.day.toString());
    debugPrint(scheduledTime.hour.toString());
    debugPrint(scheduledTime.minute.toString());
  }
  // Save the settings whenever the switch is changed
  saveSettingsSleep();
}

void scheduleRepeatingNotificationMorning(
  List<String> MorningList,
  int selectedEndTimeIndex,
  int selectedIntervalIndex,
) async {
  // Check if notifications are already scheduled
  if (repeatingNotificationIdsmorning.isNotEmpty) {
    // Cancel existing notifications
    for (int notificationId in repeatingNotificationIdsmorning) {
      AwesomeNotifications().cancelSchedule(notificationId);
    }
  }

  DateTime notificationStartTime = DateTime(
    selectedDateTime.year,
    selectedDateTime.month,
    selectedDateTime.day,
    selectedDateTime.hour,
    selectedDateTime.minute,
  );

  // Calculate the end time based on the selected option
  DateTime notificationEndTime;
  switch (selectedEndTimeIndex) {
    case 0: // 1 hour
      notificationEndTime = notificationStartTime.add(const Duration(hours: 1));
      break;
    case 1: // 2 hours
      notificationEndTime = notificationStartTime.add(const Duration(hours: 2));
      break;
    case 2: // 3 hours
      notificationEndTime = notificationStartTime.add(const Duration(hours: 3));
      break;
    default:
      // Default to 1 hour
      notificationEndTime = notificationStartTime.add(const Duration(hours: 1));
      break;
  }

  // Calculate the time difference between start and end times
  Duration timeDifference =
      notificationEndTime.difference(notificationStartTime);

  // Calculate the interval duration based on the selected option
  int intervalInMinutes;
  switch (selectedIntervalIndex) {
    case 0: // 1 minute
      intervalInMinutes = 1;
      break;
    case 1: // 5 minutes
      intervalInMinutes = 5;
      break;
    case 2: // 10 minutes
      intervalInMinutes = 10;
      break;
    default:
      // Default to 1 minute
      intervalInMinutes = 1;
      break;
  }

  // Calculate the number of intervals based on the selected option
  int intervals = timeDifference.inMinutes ~/ intervalInMinutes;

  // Schedule notifications with the selected interval
  for (int i = 0; i < intervals && i < MorningList.length; i++) {
    DateTime scheduledTime =
        notificationStartTime.add(Duration(minutes: i * intervalInMinutes));

    int notificationId = i + 1;
    repeatingNotificationIdsmorning.add(notificationId);

    await NotificationServices.showNotification(
      id: notificationId,
      channelKey: 'basic_channel',
      title: 'أذكار الصباح',
      body: MorningList[i], // Use the body from the list
      scheduled: true,
      year: scheduledTime.year,
      month: scheduledTime.month,
      day: scheduledTime.day,
      hour: scheduledTime.hour,
      minute: scheduledTime.minute,
      second: 0,
      allowWhileIdle: true,
    );

    debugPrint(scheduledTime.year.toString());
    debugPrint(scheduledTime.month.toString());
    debugPrint(scheduledTime.day.toString());
    debugPrint(scheduledTime.hour.toString());
    debugPrint(scheduledTime.minute.toString());
  }
  // Save the settings whenever the switch is changed
  saveSettingsMorning();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const ImageIcon(
            AssetImage(Assets.imagesLeftArrow),
            color: MyColors.petrol,
          ),
          onPressed: () {
            Navigator.pushNamed(context, home);
          },
        ),
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'الاشعارات',
            style: TextStyle(color: MyColors.petrol, fontSize: 32),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            buildSwitchListTile(),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 22),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    ' اشعارات أذكار الصباح',
                    style: TextStyle(
                      color: MyColors.petrol,
                      fontSize: 18,
                    ),
                  ),
                  value: isSwitched,
                  activeColor: Colors.white,
                  activeTrackColor: MyColors.petrol,
                  inactiveTrackColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      if (isSwitched) {
                        // Call the notification function when the switch is turned on
                        scheduleRepeatingNotificationMorning(
                          morningList,
                          selectedEndTimeIndex,
                          selectedIntervalIndex,
                        );
                      } else {
                        for (int notificationId
                            in repeatingNotificationIdsmorning) {
                          AwesomeNotifications().cancelSchedule(notificationId);
                          saveSettingsMorning();
                        }
                      }
                    });
                    // Save the settings whenever the switch is changed
                    // saveSettings();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 22),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'اشعارات أذكار المساء',
                    style: TextStyle(
                      color: MyColors.petrol,
                      fontSize: 18,
                    ),
                  ),
                  value: isSwitched,
                  activeColor: Colors.white,
                  activeTrackColor: MyColors.petrol,
                  inactiveTrackColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      if (isSwitched) {
                        // Call the notification function when the switch is turned on
                        scheduleRepeatingNotificationNight(
                          NightList,
                          selectedEndTimeIndex,
                          selectedIntervalIndex,
                        );
                      } else {
                        for (int notificationId
                            in repeatingNotificationIdsnight) {
                          AwesomeNotifications().cancelSchedule(notificationId);
                          saveSettingsNight();
                        }
                      }
                    });
                    // Save the settings whenever the switch is changed
                    // saveSettings();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 22),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'اشعارات أذكار الصلاة',
                    style: TextStyle(
                      color: MyColors.petrol,
                      fontSize: 18,
                    ),
                  ),
                  value: isSwitched,
                  activeColor: Colors.white,
                  activeTrackColor: MyColors.petrol,
                  inactiveTrackColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      if (isSwitched) {
                        // Call the notification function when the switch is turned on
                        scheduleRepeatingNotificationSalah(
                          TitelSalahList,
                          SubTitleSalahlList,
                          selectedEndTimeIndex,
                          selectedIntervalIndex,
                        );
                      } else {
                        for (int notificationId
                            in repeatingNotificationIdssalah) {
                          AwesomeNotifications().cancelSchedule(notificationId);
                          saveSettingsSalah();
                        }
                      }
                    });
                    // Save the settings whenever the switch is changed
                    // saveSettings();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 22),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'اشعارات أذكار بعد الصلاة',
                    style: TextStyle(
                      color: MyColors.petrol,
                      fontSize: 18,
                    ),
                  ),
                  value: isSwitched,
                  activeColor: Colors.white,
                  activeTrackColor: MyColors.petrol,
                  inactiveTrackColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      if (isSwitched) {
                        // Call the notification function when the switch is turned on
                        scheduleRepeatingNotificationAfterSalah(
                          AfterSalahList,
                          selectedEndTimeIndex,
                          selectedIntervalIndex,
                        );
                      } else {
                        for (int notificationId
                            in repeatingNotificationIdsaftersalah) {
                          AwesomeNotifications().cancelSchedule(notificationId);
                          saveSettingsAfterSalah();
                        }
                      }
                    });
                    // Save the settings whenever the switch is changed
                    // saveSettings();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 22),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'اشعارات أذكار النوم',
                    style: TextStyle(
                      color: MyColors.petrol,
                      fontSize: 18,
                    ),
                  ),
                  value: isSwitched,
                  activeColor: Colors.white,
                  activeTrackColor: MyColors.petrol,
                  inactiveTrackColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      if (isSwitched) {
                        // Call the notification function when the switch is turned on
                        scheduleRepeatingNotificationSleep(
                          SleepList,
                          selectedEndTimeIndex,
                          selectedIntervalIndex,
                        );
                      } else {
                        for (int notificationId
                            in repeatingNotificationIdssleep) {
                          AwesomeNotifications().cancelSchedule(notificationId);
                          saveSettingsSleep();
                        }
                      }
                    });
                    // Save the settings whenever the switch is changed
                    // saveSettings();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ValueListenableBuilder<Box> buildSwitchListTile() {
    return ValueListenableBuilder(
      valueListenable: Hive.box('adhan_view_box').listenable(),
      builder: (context, box, child) {
        var isAllowed = box.get('isAllowed', defaultValue: false);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SwitchListTile(
            title: const Text(
              ' اشعارات الأذان ',
              style: TextStyle(
                color: MyColors.petrol,
                fontSize: 18,
              ),
            ),
            value: isAllowed,
            activeTrackColor: MyColors.petrol,
            activeColor: const Color(0xffffffff),
            inactiveTrackColor: Colors.white,
            // inactiveThumbColor:Color(0xffF5D49B) ,

            onChanged: (value) {
              box.put('isAllowed', value);

              setState(() {
                isAllowed = value;
                isAllowed
                    ? schedulePrayerTimeNotifications()
                    : ClearNotification();
              });
            },
          ),
        );
      },
    );
  }

  void schedulePrayerTimeNotification(int index, String prayerTime) async {
    await NotificationServices.showNotification(
      channelKey: 'alarm chanel',
      title: 'مواقيت الصلاه',
      body: 'حان الان موعد صلاة ${getPrayerName(index)}',
      scheduled: true,
      year: DateTime.now().year,
      day: DateTime.now().day,
      month: DateTime.now().month,
      hour: getHour(prayerTime),
      minute: getMinute(prayerTime),
      id: index + 1,
      allowWhileIdle: true,
    );

    debugPrint(DateTime.now().year.toString());
    debugPrint(DateTime.now().month.toString());
    debugPrint(DateTime.now().day.toString());
    debugPrint(getHour(prayerTime).toString());
    debugPrint(getMinute(prayerTime).toString());
  }

  void schedulePrayerTimeNotifications() {
    final myCoordinates = Coordinates(30.597246, 30.987632);
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);

    List<String> prayerTimesList = [
      intl.DateFormat.jm().format(prayerTimes.fajr),
      intl.DateFormat.jm().format(prayerTimes.sunrise),
      intl.DateFormat.jm().format(prayerTimes.dhuhr),
      intl.DateFormat.jm().format(prayerTimes.asr),
      intl.DateFormat.jm().format(prayerTimes.maghrib),
      intl.DateFormat.jm().format(prayerTimes.isha),
    ];
    for (int i = 0; i < prayerTimesList.length; i++) {
      schedulePrayerTimeNotification(i, prayerTimesList[i]);
      notificationIds.add(i + 1);
    }
  }

  void ClearNotification() {
    for (int id in notificationIds) {
      AwesomeNotifications().cancelSchedule(id);
    }
    notificationIds.clear();
  }

  int getHour(String time) {
    try {
      String cleanedTime = replaceNumbers(time);

      // Extract the hour part
      int hour = int.parse(cleanedTime.split(':')[0]);

      // If PM, add 12 to the hour
      if (cleanedTime.toLowerCase().contains('pm')) {
        hour += 12;
      }

      return hour;
    } catch (e) {
      debugPrint('Error parsing hour: $e');
      return 0;
    }
  }

  int getMinute(String time) {
    try {
      String cleanedTime = replaceNumbers(time);

      // Extract the minutes part
      int minutes =
          int.parse(cleanedTime.split(':')[1].replaceAll(RegExp('[^0-9]'), ''));

      return minutes;
    } catch (e) {
      debugPrint('Error parsing minute: $e');
      return 0;
    }
  }

  String getPrayerName(int index) {
    switch (index) {
      case 0:
        return "الفجـــر";
      case 1:
        return 'الشروق';
      case 2:
        return 'الظهر';
      case 3:
        return 'العصر';
      case 4:
        return 'المغرب';
      case 5:
        return 'العشاء';
      default:
        return '';
    }
  }

  String replaceNumbers(String number) {
    const english = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      'AM',
      'PM'
    ];
    const farsi = ['۰', '۱', '۲', '۳', '٤', '٥', '٦', '۷', '۸', '۹', 'ص', 'م'];
    for (int i = 0; i < english.length; i++) {
      number = number.replaceAll(english[i], farsi[i]);
    }

    return number;
  }
}
