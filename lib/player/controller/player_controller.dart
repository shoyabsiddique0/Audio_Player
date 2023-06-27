import 'package:audio_player/player/model/media_item.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class PlayerController extends GetxController {
  final audioPlayer = AudioPlayer().obs;
  final loopMode = true.obs;
  final mute = false.obs;
  final bookmarks = [].obs;
  final volume = 1.0.obs;
  final muteVal = false.obs;
  final playback = 4.obs;
  final playlist = ConcatenatingAudioSource(children: [
    AudioSource.uri(
        Uri.parse(
            "https://pagalsong.in/uploads/systemuploads/mp3/Rab Ne Bana Di Jodi/Tujh Mein Rab Dikhta Hai - Rab Ne Bana Di Jodi 128 Kbps.mp3"),
        tag: MediaItem(
          id: "1",
          title: "Tujh Mein Rab Dikhta Hai",
          artist: "Shreya Ghosal, Salim - Sulaiman",
          artUri: "assets/PlaylistAssets/songCard.png",
        )),
    AudioSource.uri(
        Uri.parse(
            "https://pagalsong.in/uploads/systemuploads/mp3/Zihaal e Miskin - Vishal Mishr/Zihaal e Miskin - Vishal Mishra 128 Kbps.mp3"),
        tag: MediaItem(
          id: "2",
          title: "Zihaal e Miskin",
          artist: "Vishal Mishra",
          artUri: "assets/PlaylistAssets/songCard.png",
        )),
    AudioSource.uri(
        Uri.parse(
            "https://pagalsong.in/uploads/systemuploads/mp3/Dhindora/Dhindora - Dhindora 128 Kbps.mp3"),
        tag: MediaItem(
          id: "3",
          title: "Dhindora",
          artist: "Bhuvan Bam",
          artUri: "assets/PlaylistAssets/songCard.png",
        )),
    AudioSource.uri(
        Uri.parse(
            "https://pagalsong.in/uploads/systemuploads/mp3/Dhindora/Bann Gayi Zindagi - Dhindora 128 Kbps.mp3"),
        tag: MediaItem(
          id: "4",
          title: "Ban Gayi Zindagi",
          artist: "Bhuvan Bam",
          artUri: "assets/PlaylistAssets/songCard.png",
        )),
  ]);
  @override
  void onInit() {
    _init();
    super.onInit();
  }

  void _init() async {
    await audioPlayer.value.setLoopMode(LoopMode.all);
    await audioPlayer.value.setAudioSource(playlist);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    audioPlayer.value.dispose();
    super.onClose();
  }
}
