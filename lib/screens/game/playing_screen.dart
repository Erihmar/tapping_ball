import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapping_ball/constants/color_const.dart';
import 'package:tapping_ball/constants/dimen_const.dart';
import 'package:tapping_ball/screens/menu/menu_screen.dart';

import '../../controller/game_controller.dart';
import '../../controller/settings_controller.dart';
import '../../custom_widgets/custom_image_button.dart';
import '../../custom_widgets/custom_text.dart';

class GamePlayScreen extends StatelessWidget {
  final GameController gameController = Get.put(GameController());
  final settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,

      body: Obx(() {
        if (gameController.isGameOver.value) {
          return Container(
            padding: EdgeInsets.all(10.w),
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/intro_bg.webp"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "game_over".tr,
                    fontSize: 40.sp,
                    color: Colors.brown,
                  ),
                  Container(
                    width: 350.w,
                    height: 300.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/game_over.webp"),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "score".tr,
                          fontSize: 25.sp,
                        ),
                        CustomText(
                          text: "${gameController.score}",
                          fontSize: 35.sp,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomImageButton(
                      onTap: () {
                        gameController.startGame();
                      },
                      text: "restart".tr),
                  kSizedBoxH20,

                     CustomImageButton(
                        onTap: () {
                          gameController.stopSound();
                          Get.offAll(const MenuScreen());
                        },
                        text: "menu".tr),

                ],
              ),
            ),
          );
        } else {
          return Obx(
            () => (gameController.isGameOverPre.value)
                ? FadeTransition(
                    opacity: gameController.fadeAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/basket_court.webp"),
                          //image: AssetImage(gameController.changeBackgroundMedium.value?"assets/images/medium_bg.webp":gameController.changeBackgroundHard.value?"assets/images/hard_bg.webp":"assets/images/basket_court.webp"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [

                          Positioned(
                            top: 40.h,
                            left: 100.w,
                            child: Row(
                              children: [
                                CustomText(text: "score".tr, fontSize: 30.sp),
                                Obx(
                                      () => CustomText(
                                    text: gameController.isGameOver.value
                                        ? ""
                                        : (gameController.score.toString()),
                                    fontSize: 30.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 40.h,
                            right: 20.w,
                            child: Obx(() => GestureDetector(
                                onTap: settingsController.toggleMusic,
                                child: Container(
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: settingsController.isMusicOn.value
                                        ? secondaryColor
                                        : Colors.red,
                                  ),
                                  child: Icon(
                                    settingsController.isMusicOn.value
                                        ? Icons.volume_up
                                        : Icons.volume_off,
                                    size: 35.w,
                                    color: whiteColor,
                                  ),
                                ))),
                          ),
                          Positioned(
                              top: MediaQuery.of(context).size.height * .3.h,
                              left: 50.w,
                              child: FadeTransition(
                                opacity: gameController.fadeAnimation,
                                child: CustomText(
                                  color: Colors.white,
                                  text: gameController.showText.value
                                      ? (gameController.changeBackgroundEasy.value
                                      ? "easy".tr
                                      : gameController
                                      .changeBackgroundMedium.value
                                      ? "medium".tr
                                      :gameController
                                      .changeBackgroundHard.value
                                      ? "hard".tr: "hardest".tr)
                                      : "",
                                  fontSize:gameController
                                      .changeBackgroundHardest.value
                                      ?50.sp: 45.sp,
                                ),
                              )),
                          Positioned(
                            top: 40.h,
                            left: 20.w,
                            child: Obx(() => Container(
                              width: 40.w,
                              height: 40.h,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/basket_ball.webp"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              child: Center(
                                child: CustomText(
                                  text: '${gameController.missChance}',
                                  fontSize: 30.sp,
                                ),
                              ),
                            )),
                          ),
                          ...gameController.bubbles
                              .map((bubble) => FloatingBubble(
                            key: ValueKey(bubble.id),
                            xPosition: bubble.xPosition,
                            onTapped: () =>
                                gameController.removeBubble(bubble.id),
                            onMissed: gameController.bubbleMissed,
                          ))
                              .toList(),
                        ],
                      ),
                    ),
                  )
                : Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/basket_court.webp"),
                        //image: AssetImage(gameController.changeBackgroundMedium.value?"assets/images/medium_bg.webp":gameController.changeBackgroundHard.value?"assets/images/hard_bg.webp":"assets/images/basket_court.webp"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [

                        Positioned(
                          top: 40.h,
                          left: 130.w,
                          child: Obx(
                            () => CustomText(
                              text: gameController.isGameOver.value
                                  ? ""
                                  : '${'score'.tr}: ${gameController.score}',
                              fontSize: 30.sp,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 40.h,
                          right: 20.w,
                          child: Obx(() => GestureDetector(
                              onTap: settingsController.toggleMusic,
                              child: Container(
                                padding: EdgeInsets.all(5.w),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: settingsController.isMusicOn.value
                                      ? secondaryColor
                                      : Colors.red,
                                ),
                                child: Icon(
                                  settingsController.isMusicOn.value
                                      ? Icons.volume_up
                                      : Icons.volume_off,
                                  size: 30.w,
                                  color: whiteColor,
                                ),
                              ))),
                        ),
                        Center(

                            child: FadeTransition(
                              opacity: gameController.fadeAnimation,
                              child: CustomText(
                                color: Colors.white,
                                text: gameController.showText.value
                                    ? (gameController.changeBackgroundEasy.value
                                    ? "easy".tr
                                    : gameController
                                    .changeBackgroundMedium.value
                                    ? "medium".tr
                                    :gameController
                                    .changeBackgroundHard.value
                                    ? "hard".tr: "hardest".tr)
                                    : "",
                                fontSize: 45.sp,
                              ),
                            )),
                        Positioned(
                          top: 40.h,
                          left: 20.w,
                          child: Obx(() => Container(
                                width: 40.w,
                                height: 40.h,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/basket_ball.webp"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                child: Center(
                                  child: CustomText(
                                    text: '${gameController.missChance}',
                                    fontSize: 30.sp,
                                  ),
                                ),
                              )),
                        ),
                        ...gameController.bubbles
                            .map((bubble) => FloatingBubble(
                                  key: ValueKey(bubble.id),
                                  xPosition: bubble.xPosition,
                                  onTapped: () =>
                                      gameController.removeBubble(bubble.id),
                                  onMissed: gameController.bubbleMissed,
                                ))
                            .toList(),
                      ],
                    ),
                  ),
          );
        }
      }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: gameController.startGame,
      //   child: Icon(Icons.play_arrow),
      // ),
    );
  }
}

class FloatingBubble extends StatefulWidget {
  final double xPosition;
  final VoidCallback onTapped;
  final VoidCallback onMissed;

  const FloatingBubble({
    Key? key,
    required this.xPosition,
    required this.onTapped,
    required this.onMissed,
  }) : super(key: key);

  @override
  _FloatingBubbleState createState() => _FloatingBubbleState();
}

class _FloatingBubbleState extends State<FloatingBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2300),
      vsync: this,
    )..forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onMissed();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: widget.xPosition * MediaQuery.of(context).size.width * .8,
          top: _controller.value * MediaQuery.of(context).size.height,
          child: GestureDetector(
            onTap: () {
              widget.onTapped();
              _controller.stop();
            },
            child: BubbleWidget(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class BubbleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/basket_ball.webp',
      width: 70.w,
      height: 70.h,
    );
  }
}
