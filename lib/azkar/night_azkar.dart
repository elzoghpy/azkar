// ignore_for_file: use_full_hex_values_for_flutter_colors, avoid_print, non_constant_identifier_names

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:azkar_notification/constants/app_striengs.dart';
import 'package:azkar_notification/constants/assets.dart';
import 'package:azkar_notification/constants/lists/listes.dart';
import 'package:azkar_notification/constants/mycolors.dart';
import 'package:azkar_notification/models/azkar_model.dart';
import 'package:azkar_notification/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart' as intl;

class NightAzkarScreen extends StatefulWidget {
  const NightAzkarScreen({super.key});

  @override
  State<NightAzkarScreen> createState() => _NightAzkarScreenState();
}

class _NightAzkarScreenState extends State<NightAzkarScreen> {
  final String boxName = 'night_model_box';

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final box = await Hive.openBox<NightModel>(boxName);
    final NightModel? savedModel = box.get('settings');

    if (savedModel != null) {
      setState(() {
        selectedEndTimeIndex = savedModel.endTime;
        selectedIntervalIndex = savedModel.intervalTime;
        selectedDateTime = savedModel.startTime;
        isSwitched = savedModel.isAllowed;
      });
    }
  }

  Future<void> saveSettings() async {
    final box = await Hive.openBox<NightModel>(boxName);
    final nightmodel = NightModel(
      endTime: selectedEndTimeIndex,
      intervalTime: selectedIntervalIndex,
      startTime: selectedDateTime,
      isAllowed: isSwitched,
    );
    await box.put('settings', nightmodel);
  }

  int selectedEndTimeIndex = 0; // Default index for end time
  int selectedIntervalIndex = 0; // Default index for interval

  List<String> endTimes = EndTimes;

  List<String> intervals = Intervals;

  List<int> repeatingNotificationIds = [];

  DateTime selectedDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 19, 0);

  bool isSwitched = false;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
    );

    if (picked != null) {
      DateTime selectedTime = DateTime(
        selectedDateTime.year,
        selectedDateTime.month,
        selectedDateTime.day,
        picked.hour,
        picked.minute,
      );

      // Check if the selected time is before the current time
      if (selectedTime.isBefore(DateTime.now())) {
        // If it's in the past, add one day to the selected date
        selectedTime = selectedTime.add(const Duration(days: 1));
      } else {
        // If it's in the future, set it to today
        selectedTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          picked.hour,
          picked.minute,
        );
      }

      // Cancel existing notifications
      for (int notificationId in repeatingNotificationIds) {
        AwesomeNotifications().cancelSchedule(notificationId);
      }

      setState(() {
        selectedDateTime = selectedTime;
      });

      // If the switch is on, reschedule notifications
      if (isSwitched) {
        scheduleRepeatingNotification(
          NightList,
          selectedEndTimeIndex,
          selectedIntervalIndex,
        );
      }

      // Save the settings whenever the time is selected
      saveSettings();
    }
  }

  void scheduleRepeatingNotification(
    List<String> eveningList,
    int selectedEndTimeIndex,
    int selectedIntervalIndex,
  ) async {
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();

    // Check if notifications are already scheduled
    if (repeatingNotificationIds.isNotEmpty) {
      // Cancel existing notifications
      for (int notificationId in repeatingNotificationIds) {
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
        notificationEndTime =
            notificationStartTime.add(const Duration(hours: 1));
        break;
      case 1: // 2 hours
        notificationEndTime =
            notificationStartTime.add(const Duration(hours: 2));
        break;
      case 2: // 3 hours
        notificationEndTime =
            notificationStartTime.add(const Duration(hours: 3));
        break;
      default:
        // Default to 1 hour
        notificationEndTime =
            notificationStartTime.add(const Duration(hours: 1));
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
    for (int i = 0; i < intervals && i < eveningList.length; i++) {
      DateTime scheduledTime =
          notificationStartTime.add(Duration(minutes: i * intervalInMinutes));

      int notificationId = i + 1;
      repeatingNotificationIds.add(notificationId);

      await NotificationServices.showNotification(
        id: notificationId,
        channelKey: 'basic_channel',
        title: 'أذكار المساء',
        body: eveningList[i], // Use the body from the list
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
    saveSettings();
  }

  List<String> NightList = nightList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: const ImageIcon(
                AssetImage(Assets.imagesLeftArrow),
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, azkar);
              },
            ),
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.petrol,
            centerTitle: true,
            title: const Text(
              'أذكار المساء',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SliverToBoxAdapter(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 2, color: MyColors.petrol)),
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            'تفعيل الاشعارات',
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
                                scheduleRepeatingNotification(
                                  NightList,
                                  selectedEndTimeIndex,
                                  selectedIntervalIndex,
                                );
                              } else {
                                for (int notificationId
                                    in repeatingNotificationIds) {
                                  AwesomeNotifications()
                                      .cancelSchedule(notificationId);
                                  saveSettings();
                                }
                              }
                            });
                            // Save the settings whenever the switch is changed
                            // saveSettings();
                          },
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          children: [
                            const Text(
                              'الوقت المحدد لارسال الاشعارات :',
                              style: TextStyle(
                                color: MyColors.petrol,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              replaceNumbers(intl.DateFormat.jm()
                                  .format(selectedDateTime)),
                              style: const TextStyle(
                                  color: MyColors.petrol,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                color: MyColors.petrol,
                                onPressed: () => _selectTime(context),
                                icon: const Icon(Icons.edit_calendar)),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            'وقت الانتهاء:',
                            style: TextStyle(
                              fontSize: 14,
                              color: MyColors.petrol,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          DropdownButton<int>(
                            alignment: Alignment.center,
                            borderRadius: BorderRadius.circular(10),
                            value: selectedEndTimeIndex,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: MyColors.petrol,
                            ),
                            dropdownColor: Colors.white,
                            items: endTimes.map((String value) {
                              return DropdownMenuItem<int>(
                                value: endTimes.indexOf(value),
                                child: Text(
                                  value,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (int? newValue) {
                              setState(() {
                                selectedEndTimeIndex = newValue!;
                              });
                              // Handle the selected end time here
                              debugPrint(
                                  'Selected End Time: ${endTimes[selectedEndTimeIndex]}');
                            },
                          ),
                          const Spacer(),
                          const Text(
                            'الفاصل  بين الإشعارات:',
                            style: TextStyle(
                              fontSize: 13,
                              color: MyColors.petrol,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          DropdownButton<int>(
                            alignment: Alignment.center,
                            borderRadius: BorderRadius.circular(10),
                            value: selectedIntervalIndex,
                            dropdownColor: Colors.white,
                            style: const TextStyle(
                              color: MyColors.petrol,
                            ),
                            items: intervals.map((String value) {
                              return DropdownMenuItem<int>(
                                value: intervals.indexOf(value),
                                child: Text(
                                  value,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              );
                            }).toList(),
                            onChanged: (int? newValue) {
                              setState(() {
                                selectedIntervalIndex = newValue!;
                              });
                              // Handle the selected interval here
                              debugPrint(
                                  'Selected Interval: ${intervals[selectedIntervalIndex]}');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: NightList.length,
              (context, index) => Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 4),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 2, color: MyColors.petrol),
                      bottom: BorderSide(width: 2, color: MyColors.petrol),
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      textDirection: TextDirection.rtl,
                      NightList[index],
                      style:
                          const TextStyle(color: MyColors.petrol, fontSize: 21),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
