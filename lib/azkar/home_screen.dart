import 'package:azkar_notification/constants/app_striengs.dart';
import 'package:azkar_notification/constants/assets.dart';
import 'package:azkar_notification/constants/mycolors.dart';
import 'package:flutter/material.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            const Image(
              image: AssetImage(
                Assets.images14,
                // ImageAssets.splash0Image,
              ),
              fit: BoxFit.cover,
              height: double.infinity,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 90,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 150,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'أذكار',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, notification);
                          },
                          icon: const Icon(
                            Icons.notifications_none_outlined,
                            color: MyColors.petrol,
                            size: 40,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 40, left: 16, right: 16, bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, hadiths);
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(24))),
                                    height: 250,
                                    child: const Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          child: Opacity(
                                            opacity: .8,
                                            child: Image(
                                              image:
                                                  AssetImage(Assets.images18),
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              height: 250,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 25),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 120,
                                                width: 120,
                                                child: Image(
                                                  color: Colors.white,
                                                  image: AssetImage(
                                                      Assets.imagesQuran),
                                                  height: 120,
                                                  width: 120,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text(
                                                  'أحاديث نبوية ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 40,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context, azkar);
                                      },
                                      child: Container(
                                        height: 120,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25))),
                                        child: const Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                              child: Opacity(
                                                opacity: .8,
                                                child: Image(
                                                  height: 120,
                                                  image: AssetImage(
                                                      Assets.images18),
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, left: 0),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 60,
                                                    width: 60,
                                                    child: Image(
                                                      image: AssetImage(Assets
                                                          .imagesIcons8Tasbih99),
                                                      fit: BoxFit.cover,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Text(
                                                      'أذكـــار',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 26,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context, pray);
                                      },
                                      child: Container(
                                        height: 120,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25))),
                                        child: const Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                              child: Opacity(
                                                opacity: .8,
                                                child: Image(
                                                  height: 120,
                                                  image: AssetImage(
                                                      Assets.images18),
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(children: [
                                                SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: Image(
                                                    color: Colors.white,
                                                    image: AssetImage(Assets
                                                        .imagesIcons8Pray64),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Text(
                                                    'أدعية',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context, calendar);
                                      },
                                      child: Container(
                                        height: 120,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25))),
                                        child: const Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                              child: Opacity(
                                                opacity: .8,
                                                child: Image(
                                                  height: 120,
                                                  image: AssetImage(
                                                      Assets.images18),
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, left: 0),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 60,
                                                    width: 60,
                                                    child: Image(
                                                      image: AssetImage(Assets
                                                          .imagesIcons8TearOffCalendar50),
                                                      fit: BoxFit.cover,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Text(
                                                      'التقويم الهجري',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context, compass);
                                      },
                                      child: Container(
                                        height: 120,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25))),
                                        child: const Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                              child: Opacity(
                                                opacity: .8,
                                                child: Image(
                                                  height: 120,
                                                  image: AssetImage(
                                                      Assets.images18),
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(children: [
                                                SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: Image(
                                                    color: Colors.white,
                                                    image: AssetImage(Assets
                                                        .imagesIcons8Compass50),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Text(
                                                    'أتجاه القبلة',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 3,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, adhan);
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(24))),
                                    height: 250,
                                    child: const Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          child: Opacity(
                                            opacity: .8,
                                            child: Image(
                                              image:
                                                  AssetImage(Assets.images18),
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              height: 250,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 25),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 120,
                                                width: 120,
                                                child: Image(
                                                  color: Colors.white,
                                                  image: AssetImage(Assets
                                                      .imagesIcons8Mosque80),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text(
                                                  'مواقيت الصلاة',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 32,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
