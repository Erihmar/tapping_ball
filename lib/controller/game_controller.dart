import 'dart:async';
import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tapping_ball/controller/settings_controller.dart';

class Bubble {
  final double xPosition;
  final int id;
  Bubble(this.xPosition, this.id);
}

class GameController extends GetxController with GetSingleTickerProviderStateMixin{
  var bubbles = <Bubble>[].obs;
  var score = 0.obs;
  var missedBubbles = 0.obs;
  var missChance = 3.obs;
  var bestScore = 0.obs;
  var isGameOver = false.obs;
  var isGameOverPre = false.obs;
  var changeBackgroundEasy = true.obs;
  var changeBackgroundMedium = false.obs;
  var changeBackgroundHard = false.obs;
  var changeBackgroundHardest = false.obs;
  var showText = false.obs;
  late Animation<double> fadeAnimation;
  late AnimationController controller;
  final settingsController = Get.put(SettingsController());
  Random random = Random();
  @override
  void onInit() {

    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    fadeAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    bubbles.clear();
    getBestScore();
    startGame();
    super.onInit();
  }
  @override
  void dispose() {


    controller.dispose();
    super.dispose();
  }
  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
void stopSound() async {
    var stg = GetStorage();
    settingsController.player.stop();
    settingsController.player.setVolume(0.0);
    stg.write('isMusicOn', false);
  }
  void addBubble() {
    if (!isGameOver.value) {
      //for(int i = 0; i < 2; i++){
      double xPosition = random.nextDouble();
      bubbles.add(Bubble(xPosition, DateTime.now().millisecondsSinceEpoch));
      // }
    }
  }

  void showTextForOneSecond() {
    showText.value = true;

    Timer(const Duration(seconds: 2), () {
      showText.value = false;
    });
  }

  void getBestScore() {
    final box = GetStorage();
    bestScore.value = box.read('score') ?? 0;
  }

  void restartGame() {
    isGameOver.value = false;
    isGameOverPre.value = false;
    score.value = 0;
    missedBubbles.value = 0;
    missChance.value = 3;
    bubbles.clear();
    startGame();
  }

  void removeBubble(int id) {
    bubbles.removeWhere((bubble) => bubble.id == id);
    score++;
    if (score.value < 20) {
      if (score.value == 1) {
        showTextForOneSecond();
      }
      changeBackgroundEasy.value = true;
      changeBackgroundMedium.value = false;
      changeBackgroundHard.value = false;
      changeBackgroundHardest.value = false;
    } else if (score.value >= 20 && score.value <= 40) {
      if (score.value == 21) {
        showTextForOneSecond();
      }

      changeBackgroundEasy.value = false;
      changeBackgroundMedium.value = true;
      changeBackgroundHard.value = false;
      changeBackgroundHard.value = false;
    } else if (score.value >= 41&&score.value <= 80) {
      if (score.value == 41) {
        showTextForOneSecond();
      }
      changeBackgroundEasy.value = false;
      changeBackgroundMedium.value = false;
      changeBackgroundHard.value = true;
      changeBackgroundHardest.value = false;
    }else if (score.value >= 81) {
      if (score.value == 81) {
        showTextForOneSecond();
      }
      changeBackgroundEasy.value = false;
      changeBackgroundMedium.value = false;
      changeBackgroundHard.value = false;
      changeBackgroundHardest.value = true;
    }

    final box = GetStorage();
    var bestScore = box.read('score');
    if (bestScore == null) {
      box.write('score', score.value);
      print("Updted Score for no score ${box.read('score')}");
    } else {
      if (score.value > box.read('score')) {
        box.write('score', score.value);
        print("Updted Score ${box.read('score')}");
      }
    }
  }

  void bubbleMissed() {
    missChance--;
    missedBubbles++;

    if (missedBubbles >= 3) {
      isGameOverPre.value = true;
      Future.delayed(const Duration(milliseconds: 500), () => isGameOver.value = true);

    }
  }

  void startGame() {
    isGameOver.value = false;
    isGameOverPre.value = false;
    score.value = 0;
    missedBubbles.value = 0;
    missChance.value = 3;
    bubbles.clear();
    changeBackgroundEasy.value = true;
    changeBackgroundMedium.value = false;
    changeBackgroundHard.value = false;
    changeBackgroundHardest.value = false;
    Future.doWhile(() async {
      if (isGameOver.value) return false;
      addBubble();
      if (changeBackgroundEasy.value) {
        await Future.delayed(const Duration(milliseconds: 1000));
      } else if (changeBackgroundMedium.value) {
        await Future.delayed(const Duration(milliseconds: 700));
      } else if (changeBackgroundHard.value) {
        await Future.delayed(const Duration(milliseconds: 400));
      }
      else if (changeBackgroundHardest.value) {
        await Future.delayed(const Duration(milliseconds: 200));
      }
      else {
        await Future.delayed(const Duration(milliseconds: 1000));
      }

      return true;
    });
  }
}
