// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:azkar_notification/approuter.dart';
import 'package:azkar_notification/constants/app_striengs.dart';
import 'package:azkar_notification/models/azkar_model.dart';
import 'package:azkar_notification/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';

import 'generated/l10n.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(MorningModelAdapter());
  Hive.registerAdapter(NightModelAdapter());
  Hive.registerAdapter(SalahModelAdapter());
  Hive.registerAdapter(SleepModelAdapter());
  Hive.registerAdapter(AfterSalahModelAdapter());

  await Hive.openBox<NightModel>('night_model_box');
  await Hive.openBox<MorningModel>('mornig_model_box');
  await Hive.openBox<SalahModel>('salah_model_box');
  await Hive.openBox<AfterSalahModel>('aftersalah_model_box');
  await Hive.openBox<SleepModel>('sleep_model_box');
  await Hive.openBox('adhan_view_box');

  await NotificationServices.initializeNotification();

  WidgetsFlutterBinding.ensureInitialized();
  runApp(NontificationApp(appRouter: AppRouter()));
}

class NontificationApp extends StatefulWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final AppRouter appRouter;
  const NontificationApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  @override
  State<NontificationApp> createState() => _NontificationAppState();
}

class _NontificationAppState extends State<NontificationApp> {
  bool hasPermission = false;
  Future getPermission() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      var status = await Permission.location.status;
      if (status.isGranted) {
        hasPermission = true;
      } else {
        Permission.location.request().then((value) {
          setState(() {
            hasPermission = (value == PermissionStatus.granted);
          });
        });
      }
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ar'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: widget.appRouter.generateRoute,
      initialRoute: splashScreen,
    );
  }
}
