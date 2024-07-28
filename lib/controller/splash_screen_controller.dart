
import 'package:get/get.dart';
import 'package:tapping_ball/screens/menu/menu_screen.dart';

class SplashScreenController extends GetxController{
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() =>const  MenuScreen());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}