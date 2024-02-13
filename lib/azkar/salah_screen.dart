// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'package:adhan/adhan.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:azkar_notification/constants/app_striengs.dart';
import 'package:azkar_notification/constants/assets.dart';
import 'package:azkar_notification/constants/mycolors.dart';
import 'package:azkar_notification/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart' as intl;

class AdhanScreens extends StatefulWidget {
  const AdhanScreens({Key? key}) : super(key: key);

  static const String id = 'SalahView';

  @override
  State<AdhanScreens> createState() => _AdhanScreensState();
}

class _AdhanScreensState extends State<AdhanScreens> {
  bool isAllowed = false;
  List<int> notificationIds = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.grey,
        body: Stack(
          // fit: StackFit.expand,
          children: [
            Image(
              image: const AssetImage(
                Assets.images24846,
              ),
              width: MediaQuery.sizeOf(context).width,
              // fit: BoxFit.cover,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, home);
                    },
                    child: const ImageIcon(
                      AssetImage(Assets.imagesLeftArrow),
                      size: 40,
                      color: MyColors.petrol,
                    ),
                  ),
                ),
                const SizedBox(height: 120),
                buildSwitchListTile(),
                const Center(
                  child: Text(
                    'مواقيت الصلاة',
                    style: TextStyle(
                        color: MyColors.petrol,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(child: buildPrayerTimesListView()),
              ],
            ),
          ],
        ));
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
              'تفعيل الاشعارات',
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

  ListView buildPrayerTimesListView() {
    final myCoordinates = Coordinates(30.597246, 30.987632);
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);

    List<String> prayerTimesList = [
      replaceNumbers(intl.DateFormat.jm().format(prayerTimes.fajr)),
      replaceNumbers(intl.DateFormat.jm().format(prayerTimes.sunrise)),
      replaceNumbers(intl.DateFormat.jm().format(prayerTimes.dhuhr)),
      replaceNumbers(intl.DateFormat.jm().format(prayerTimes.asr)),
      replaceNumbers(intl.DateFormat.jm().format(prayerTimes.maghrib)),
      replaceNumbers(intl.DateFormat.jm().format(prayerTimes.isha)),
    ];

    // for (int i = 0; i < prayerTimesList.length; i++) {
    //   schedulePrayerTimeNotification(i, prayerTimesList[i]);
    //   notificationIds.add(i + 1);
    // }
    List<String> prayerIconList = [
      Assets.imagesCloudComputing,
      Assets.imagesIcons8PartlyCloudyDay100,
      Assets.imagesSunrise,
      Assets.imagesIcons8PartlyCloudyDay50,
      Assets.imagesCloudyNight,
      Assets.imagesIcons8MoonAndStars100
    ];

    return ListView.builder(
      itemCount: prayerTimesList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Container(
            height: 60,
            decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(width: 3, color: MyColors.browen),
                  bottom: BorderSide(width: 3, color: MyColors.browen),
                  left: BorderSide(width: 3, color: MyColors.browen),
                  right: BorderSide(width: 3, color: MyColors.browen)),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  ImageIcon(
                      color: MyColors.petrol,
                      size: 35,
                      AssetImage(
                        prayerIconList[index],
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${getPrayerName(index)}:',
                    style: const TextStyle(
                        fontSize: 23,
                        color: MyColors.petrol,
                        fontWeight: FontWeight.bold
                        // color: Color(0xffFBE6C5),
                        ),
                  ),
                  const Spacer(),
                  Text(
                    prayerTimesList[index],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: MyColors.petrol,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
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
