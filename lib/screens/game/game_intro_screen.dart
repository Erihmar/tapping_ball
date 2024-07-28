import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapping_ball/constants/color_const.dart';
import 'package:tapping_ball/custom_widgets/custom_text.dart';
import 'package:tapping_ball/screens/game/playing_screen.dart';
import 'package:tapping_ball/screens/menu/menu_screen.dart';

class GameIntroScreen extends StatefulWidget {
  const GameIntroScreen({super.key});

  @override
  _GameIntroScreenState createState() => _GameIntroScreenState();
}

class _GameIntroScreenState extends State<GameIntroScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/intro_bg.webp"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
              Get.to( GamePlayScreen());
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    // child: ScaleTransition(
                    //   scale: _scaleAnimation,
                      child: Image.asset(
                        "assets/images/intro.webp",
                        width: 300.w,
                        height: 300.h,
                      ),
                    //),
                  ),

                  GestureDetector(
                    onTap: () {
                      Get.to( GamePlayScreen());
                    },
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: CustomText(
                        text: "Tap To Play",
                        fontSize: 40.sp,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                Get.offAll(const MenuScreen());
              },
              child: Image.asset(
                "assets/images/home_btn.webp",
                width: 100.w,
                height: 100.h,
              ),
            )
          ],
        ),
      ),
    );
  }
}