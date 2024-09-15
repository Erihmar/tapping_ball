import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapping_ball/constants/color_const.dart';
import 'package:tapping_ball/constants/dimen_const.dart';
import 'package:tapping_ball/custom_widgets/custom_card.dart';
import 'package:tapping_ball/custom_widgets/custom_text.dart';
import 'package:tapping_ball/screens/settings/change_language_screen.dart';
import 'package:tapping_ball/screens/settings/privacy_policy_screen.dart';

import '../../controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.put(SettingsController());
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60.h,

        leading: Padding(
          padding:  EdgeInsets.all(10.w),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                "assets/images/left_btn.webp",
                width: 50.w,
                height: 50.h,
              )),
        ),
        leadingWidth: 60.w,
        //iconTheme: const IconThemeData(color: Colors.brown),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: CustomText(
          text: "settings".tr,
          fontSize: 20.sp,
          color: Colors.brown,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.w),
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/intro_bg.webp"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100.h,),
            CustomText(text: "language_settings".tr,fontSize: 16.sp,color: Colors.brown,fontWeight: FontWeight.bold,),
            GestureDetector(
              onTap: () {
                Get.to(const ChangeLanguageScreen());
              },
              child: CustomCard(
                  widget: Container(
                    padding: EdgeInsets.all(10.w),
                    width: MediaQuery.of(context).size.width,
                    height: 60.h,
                    decoration:const BoxDecoration(
                      //color: color ?? cardColor,
                        image: DecorationImage(
                          image: AssetImage("assets/images/wood_bggg.webp"),
                          fit: BoxFit.cover,
                        )),
                    child: Row(
                      children: [
                        CustomText(
                          text: "change_language".tr,
                          fontSize: 20.sp,
                        ),
                        const Spacer(),
                        Icon(
                         Icons.language,
                          color: Colors.white,
                          size: 30.w,
                        )
                      ],
                    ),
                  )),
            ),
            kSizedBoxH10,
             CustomText(text: "sound_settings".tr,fontSize: 16.sp,color: Colors.brown,fontWeight: FontWeight.bold),
            Obx(()=>
              GestureDetector(
                onTap: () {
                  settingsController.toggleMusic();
                },
                child: CustomCard(
                    widget: Container(
                  padding: EdgeInsets.all(10.w),
                  width: MediaQuery.of(context).size.width,
                  height: 60.h,
                  decoration:const BoxDecoration(
                      //color: color ?? cardColor,
                      image: DecorationImage(
                    image: AssetImage("assets/images/wood_bggg.webp"),
                    fit: BoxFit.cover,
                  )),
                  child: Row(
                    children: [
                      CustomText(
                        text: "sound".tr,
                        fontSize: 20.sp,
                      ),
                      const Spacer(),
                       Icon(
                         (settingsController.isMusicOn.value)? Icons.volume_up:Icons.volume_off,
                             color: Colors.white,
                             size: 30.w,
                           )
                    ],
                  ),
                )),
              ),
            ),
            kSizedBoxH10,
             CustomText(text: "general".tr,fontSize: 16.sp,color: Colors.brown,fontWeight: FontWeight.bold,),

            GestureDetector(
              onTap: () {
                Get.to(const PrivacyPolicyScreen());
              },
              child: CustomCard(
                  widget: Container(
                    padding: EdgeInsets.all(10.w),
                    width: MediaQuery.of(context).size.width,
                    height: 60.h,
                    decoration:const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/wood_bggg.webp"),
                          fit: BoxFit.cover,
                        )),
                    child: Row(
                      children: [
                        CustomText(
                          text: "policy".tr,
                          fontSize: 20.sp,
                        ),
                        const Spacer(),
                        Icon(
                          Icons.info,
                          color: Colors.white,
                          size: 30.w,
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
