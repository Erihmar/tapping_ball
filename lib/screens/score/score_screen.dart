import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapping_ball/constants/color_const.dart';
import 'package:tapping_ball/constants/dimen_const.dart';
import 'package:tapping_ball/custom_widgets/custom_text.dart';

import '../../controller/game_controller.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameController = Get.put(GameController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: primaryColor,
      appBar: AppBar(
        toolbarHeight: 60.h,
        elevation: 0,
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
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: CustomText(text: "score".tr,fontSize: 25.sp,color: Colors.brown,fontWeight: FontWeight.bold,),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/intro_bg.webp"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
mainAxisAlignment: MainAxisAlignment.center,
          children: [
            kSizedBoxH20,
            Center(
              child: Container(
                width: 300.w,
                height: 300.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/score_board.webp"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: "best_score".tr,fontSize: 35.sp,),

                    kSizedBoxH20,CustomText(text: "${gameController.bestScore.toString()} ",fontSize: 40.sp,),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
