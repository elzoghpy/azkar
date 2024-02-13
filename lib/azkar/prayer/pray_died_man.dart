// ignore_for_file: use_full_hex_values_for_flutter_colors, avoid_print, non_constant_identifier_names

import 'package:azkar_notification/constants/app_striengs.dart';
import 'package:azkar_notification/constants/assets.dart';
import 'package:azkar_notification/constants/lists/listes.dart';
import 'package:azkar_notification/constants/mycolors.dart';
import 'package:flutter/material.dart';

class PrayDiedMView extends StatefulWidget {
  const PrayDiedMView({super.key});

  @override
  State<PrayDiedMView> createState() => _PrayDiedmView();
}

class _PrayDiedmView extends State<PrayDiedMView> {
  List<String> PrayDiedMList = praydiedmanlist;

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
                Navigator.pushNamed(context, home);
              },
            ),
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.petrol,
            centerTitle: true,
            title: const Text(
              'أدعوني أستجيب لكم',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SliverToBoxAdapter(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                  color: MyColors.petrol,
                                ),
                                child: TextButton(
                                  child: const Text(
                                    'الدعاء',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, pray);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                  color: MyColors.petrol,
                                ),
                                child: TextButton(
                                  child: const Text(
                                    ' دعاء للمتوفى',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, praydiedM);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                  color: MyColors.petrol,
                                ),
                                child: TextButton(
                                  child: const Text(
                                    'دعاء للمتوفية',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, praydiedW);
                                  },
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: PrayDiedMList.length,
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
                      PrayDiedMList[index],
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
}
