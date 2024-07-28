import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  var isMusicOn = false.obs;
  var isVibrationOn = false.obs;
  final player = AudioPlayer();
  final player1 = AudioPlayer();
  @override
  void onInit() {
    var storage = GetStorage();
     isMusicOn.value = storage.read('isMusicOn') ?? false;
    playSound();
     if (isMusicOn.value) {
       player.setVolume(1.0);
     } else {
       player.setVolume(0.0);
     }

    super.onInit();
  }

  @override
  void onClose() {

    super.onClose();
  }

  void toggleMusic() {
    var stg = GetStorage();
    if (isMusicOn.value) {
      player.setVolume(0.0);
      isMusicOn.value = false;
      stg.write('isMusicOn', false);
    } else {
      player.setVolume(1.0);
      isMusicOn.value = true;
      stg.write('isMusicOn', true);
    }
  }

  void playSound() async {

      await player.play(AssetSource('audio/MainTheme.mp3'));


  }

  void stopSound() async {
    var stg = GetStorage();

    player.setVolume(0.0);
    stg.write('isMusicOn', false);
  }
}
