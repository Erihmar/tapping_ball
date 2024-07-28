import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapping_ball/constants/color_const.dart';
import 'package:tapping_ball/constants/dimen_const.dart';
import 'package:tapping_ball/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import 'controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashScreenController = Get.put(SplashScreenController());
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/intro_bg.webp"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/splash_bg.webp",width: 150.w,height: 150.h,),
             kSizedBoxH30,
            // const CircularProgressIndicator(
            //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            // ),
            // kSizedBoxH30,
              CustomText(text: 'Try your best', color: Colors.brown, fontSize: 30.sp, fontWeight: FontWeight.bold,),
          ],
        ),
      ),
    );
  }
}
