// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'dart:math';

import 'package:azkar_notification/constants/app_striengs.dart';
import 'package:azkar_notification/constants/assets.dart';
import 'package:azkar_notification/constants/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:permission_handler/permission_handler.dart';

class CompassScreen extends StatefulWidget {
  const CompassScreen({super.key});

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen>
    with SingleTickerProviderStateMixin {
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

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPermission(),
        builder: (context, snapshot) {
          if (hasPermission) {
            return const qiblah();
          } else {
            return const Scaffold(
              backgroundColor: MyColors.petrol,
            );
          }
        });
  }
}

class qiblah extends StatefulWidget {
  const qiblah({super.key});

  @override
  State<qiblah> createState() => _qiblahState();
}

Animation<double>? animation;
AnimationController? _animationController;
double begin = 0.0;

class _qiblahState extends State<qiblah> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            'قبلة الصلاة',
            style: TextStyle(color: MyColors.petrol, fontSize: 32),
          )),
        ),
        backgroundColor: MyColors.petrol,
        body: StreamBuilder(
            stream: FlutterQiblah.qiblahStream,
            builder: (context, Snapshot) {
              if (Snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                );
              }
              final qiblahDirection = Snapshot.data;
              animation = Tween(
                begin: begin,
                end: (qiblahDirection!.qiblah * (pi / 180) * -1),
              ).animate(_animationController!);
              begin = (qiblahDirection.qiblah * (pi / 180) * -1);
              _animationController!.forward(from: 0);

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${qiblahDirection.direction.toInt()}'),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: AnimatedBuilder(
                          animation: animation!,
                          builder: (context, child) => Transform.rotate(
                                angle: animation!.value,
                                child: Image.asset(Assets.imagesQibla),
                              )),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
