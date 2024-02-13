import 'package:azkar_notification/azkar/azkar_screen.dart';
import 'package:azkar_notification/azkar/azkar_sleep.dart';
import 'package:azkar_notification/azkar/calendar_screen.dart';
import 'package:azkar_notification/azkar/compass_screen.dart';
import 'package:azkar_notification/azkar/hadiths_screen.dart';
import 'package:azkar_notification/azkar/home_screen.dart';
import 'package:azkar_notification/azkar/morning_azkar.dart';
import 'package:azkar_notification/azkar/pray_azkar/after_pray_azkar.dart';
import 'package:azkar_notification/azkar/pray_azkar/pray_azkar.dart';
import 'package:azkar_notification/azkar/prayer/pray_died_man.dart';
import 'package:azkar_notification/azkar/prayer/pray_died_woman.dart';
import 'package:azkar_notification/azkar/prayer/pray_screen.dart';
import 'package:azkar_notification/azkar/salah_screen.dart';
import 'package:azkar_notification/azkar/splash_view.dart';
import 'package:azkar_notification/screens/notification_view.dart';
import 'package:flutter/material.dart';

import 'azkar/night_azkar.dart';
import 'constants/app_striengs.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case notification:
        return MaterialPageRoute(builder: (_) => const NotificationView());
      case azkar:
        return MaterialPageRoute(builder: (_) => const AzkarScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreens());
      case adhan:
        return MaterialPageRoute(builder: (_) => const AdhanScreens());
      case pray:
        return MaterialPageRoute(builder: (_) => const PrayView());
      case praydiedM:
        return MaterialPageRoute(builder: (_) => const PrayDiedMView());
      case praydiedW:
        return MaterialPageRoute(builder: (_) => const PrayDiedWView());
      case hadiths:
        return MaterialPageRoute(builder: (_) => const HadithsView());
      case compass:
        return MaterialPageRoute(builder: (_) => const CompassScreen());
      case calendar:
        return MaterialPageRoute(builder: (_) => const CalendarScreen());
      case morning:
        return MaterialPageRoute(builder: (_) => const MorningAzkraScreens());
      case night:
        return MaterialPageRoute(builder: (_) => const SleepAzkar());
      case sleep:
        return MaterialPageRoute(builder: (_) => const NightAzkarScreen());
      case prayAzkar:
        return MaterialPageRoute(builder: (_) => const PrayAzkar());
      case afterPrayAzkar:
        return MaterialPageRoute(builder: (_) => const AffterPrayAzkar());
    }
    return null;
  }
}
