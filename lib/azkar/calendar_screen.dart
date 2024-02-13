// ignore_for_file: unused_element, avoid_unnecessary_containers, unnecessary_null_comparison, non_constant_identifier_names

import 'package:azkar_notification/constants/app_striengs.dart';
import 'package:azkar_notification/constants/assets.dart';
import 'package:azkar_notification/constants/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

DateTime today = DateTime.now();

// void _ondayselected(DateTime day, DateTime focusedDay) {
//   setState() {
//     today = day;
//   }
// }

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.petrol,
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(left: 16),
                child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, home);
                    },
                    child: const ImageIcon(
                      AssetImage(
                        Assets.imagesLeftArrow,
                      ),
                      size: 30,
                      color: Colors.white,
                    )),
              );
            },
          ),
          title: const Center(
            child: Text(
              'التقويم الهجري',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          // actions: const [
          //   Padding(
          //     padding: EdgeInsets.only(right: 16),
          //     child: ImageIcon(
          //       AssetImage(Assets.imagesNotification),
          //       size: 30,
          //       color: Colors.white,
          //     ),
          //   )
          // ],
        ),
        body: calender());
  }

  Widget calender() {
    return Column(
      children: [
        Container(
          child: TableCalendar(
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            calendarStyle: const CalendarStyle(
                rangeEndDecoration: BoxDecoration(
                  color: Color(0xFF004356),
                  shape: BoxShape.circle,
                ),
                disabledDecoration: BoxDecoration(
                  color: Color(0xFF004356),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Color(0xFF004356),
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(color: MyColors.petrol)),
            locale: 'ar_eg',
            rowHeight: 45,
            headerStyle: const HeaderStyle(
                formatButtonVisible: false, titleCentered: true),
            focusedDay: today,
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2050, 11, 1),
            selectedDayPredicate: (day) {
              return isSameDay(today, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                today = selectedDay;
                // update `_focusedDay` here as well
              });
            },
            calendarBuilders: CalendarBuilders(
              todayBuilder: (context, day, focusedDay) {
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }
}
