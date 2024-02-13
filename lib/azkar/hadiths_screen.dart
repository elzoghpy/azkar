// ignore_for_file: use_full_hex_values_for_flutter_colors, avoid_print, non_constant_identifier_names

import 'package:azkar_notification/constants/app_striengs.dart';
import 'package:azkar_notification/constants/assets.dart';
import 'package:azkar_notification/constants/lists/listes.dart';
import 'package:azkar_notification/constants/mycolors.dart';
import 'package:flutter/material.dart';

class HadithsView extends StatefulWidget {
  const HadithsView({super.key});

  @override
  State<HadithsView> createState() => _HadithsViewState();
}

class _HadithsViewState extends State<HadithsView> {
  List<String> Ahadith = ahadith;

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
              'أحاديث نبوية',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SliverToBoxAdapter(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: Ahadith.length,
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
                      Ahadith[index],
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
