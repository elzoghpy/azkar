import 'package:azkar_notification/constants/app_striengs.dart';
import 'package:azkar_notification/constants/assets.dart';
import 'package:azkar_notification/constants/mycolors.dart';
import 'package:flutter/material.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 10, right: 10, bottom: 40),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, home);
                    },
                    child: const ImageIcon(
                      AssetImage(Assets.imagesLeftArrow),
                      size: 40,
                      color: MyColors.petrol,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, home);
                    },
                    child: const ImageIcon(
                      AssetImage(Assets.imagesNotification),
                      size: 40,
                      color: MyColors.petrol,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, morning);
              },
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColors.browen,
                      width: 4.0,
                    ),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: const Align(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Image(
                          image: AssetImage(Assets.imagesIcons8Tasbih99),
                          fit: BoxFit.cover,
                          color: MyColors.petrol,
                        ),
                      ),
                      Text(
                        'أذكار الصباح',
                        style: TextStyle(
                            color: MyColors.petrol,
                            fontSize: 50,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, night);
              },
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColors.browen,
                      width: 4.0,
                    ),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: const Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Image(
                          image: AssetImage(Assets.imagesIcons8Tasbih99),
                          fit: BoxFit.cover,
                          color: MyColors.petrol,
                        ),
                      ),
                      Text(
                        'أذكار المساء',
                        style: TextStyle(
                            color: MyColors.petrol,
                            fontSize: 50,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, prayAzkar);
              },
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColors.browen,
                      width: 4.0,
                    ),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: const Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Image(
                          image: AssetImage(Assets.imagesIcons8Tasbih99),
                          fit: BoxFit.cover,
                          color: MyColors.petrol,
                        ),
                      ),
                      Text(
                        'أذكار الصلاة',
                        style: TextStyle(
                            color: MyColors.petrol,
                            fontSize: 50,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, afterPrayAzkar);
              },
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColors.browen,
                      width: 4.0,
                    ),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: const Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Image(
                          image: AssetImage(Assets.imagesIcons8Tasbih99),
                          fit: BoxFit.cover,
                          color: MyColors.petrol,
                        ),
                      ),
                      Text(
                        'أذكار بعد الصلاة',
                        style: TextStyle(
                            color: MyColors.petrol,
                            fontSize: 50,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, sleep);
              },
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColors.browen,
                      width: 4.0,
                    ),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: const Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Image(
                          image: AssetImage(Assets.imagesIcons8Tasbih99),
                          fit: BoxFit.cover,
                          color: MyColors.petrol,
                        ),
                      ),
                      Text(
                        'أذكار النوم',
                        style: TextStyle(
                            color: MyColors.petrol,
                            fontSize: 50,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
