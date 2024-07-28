import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tapping_ball/constants/color_const.dart';
import 'package:tapping_ball/constants/dimen_const.dart';
import 'package:tapping_ball/custom_widgets/custom_image_button.dart';
import 'package:tapping_ball/custom_widgets/custom_text.dart';
import 'package:tapping_ball/custom_widgets/custom_text_button.dart';
import 'package:tapping_ball/screens/game/game_intro_screen.dart';
import 'package:tapping_ball/screens/score/score_screen.dart';
import 'package:tapping_ball/screens/settings/settings_screen.dart';

import '../../controller/settings_controller.dart';
import '../../utils/global.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final settingsController = Get.put(SettingsController());
  bool isAccepted = false;
  bool isChecked = false;
  String first = '';
  @override
  void initState() {
    // TODO: implement initState
    final box = GetStorage();
    first = box.read('first') ?? '';
    if (first == '') {
      WidgetsBinding.instance
          .addPostFrameCallback((_) async {
        return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => Builder(builder: (context) {
            return StatefulBuilder(
              builder: (context, StateSetter setState) {
                return AlertDialog(
                  title: CustomText(
                    text: 'Privacy Policy',
                    fontWeight: FontWeight.w500,
                    color: secondaryColor,
                  ),
                  content: SizedBox(
                    height:
                    MediaQuery.of(context).size.height *
                        0.70,
                    child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                                Global.policyEn
                                ,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,fontFamily: 'Game')),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          6)),
                                  activeColor: Colors.green,
                                  side: BorderSide(
                                    width: 1.5,
                                    color: isChecked
                                        ? Colors.green
                                        : Colors.black,
                                  ),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                      if (isChecked) {
                                        isAccepted = true;
                                      } else {
                                        isAccepted = false;
                                      }
                                    });
                                  },
                                ),
                                CustomText(
                                  text: "I agreed to the privacy policy.",
                                  fontSize: 12,
                                  color: secondaryColor,
                                )
                              ],
                            ),
                            MaterialButton(
                              disabledColor: secondaryColor
                                  .withOpacity(0.3),
                              color: isAccepted
                                  ? secondaryColor
                                  : greyColor,
                              onPressed: isAccepted
                                  ? () {
                                final box = GetStorage();
                                box.write(
                                    'first', 'notfirst');
                                Navigator.pop(context);
                              }
                                  : null,
                              child: CustomText(
                                text: 'Accept',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              },
            );
          }),
        );
      });
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/menu_bg.webp"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(

          children: [
            Spacer(),
            kSizedBoxH30,
            kSizedBoxH30,
            kSizedBoxH30,
            kSizedBoxH30,
            kSizedBoxH30,
            CustomImageButton(onTap: () {Get.to(const GameIntroScreen());}, text: "Play"),
            kSizedBoxH10,
            CustomImageButton(onTap: () {Get.to(const SettingsScreen());}, text: "Settings"),
            kSizedBoxH10,
            CustomImageButton(onTap: () {Get.to(const ScoreScreen());}, text: "Score"),
            kSizedBoxH30,
            kSizedBoxH30,
            CustomText(text: "Version 1.0.0", fontSize: 18.sp),
            kSizedBoxH30,
            CustomImageButton(onTap: () {exit(0);}, text: "Exit"),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
