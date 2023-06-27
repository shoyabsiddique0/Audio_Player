import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class PlayerController extends GetxController {
  final audioPlayer = AudioPlayer().obs;
  final loopMode = true.obs;
  final mute = false.obs;
  final RxList<Duration> bookmarks = <Duration>[].obs;
  final volume = 1.0.obs;
  final muteVal = false.obs;
  final playback = 4.obs;
  final currPos = 0.0.obs;
  final playlist = ConcatenatingAudioSource(children: [
    AudioSource.uri(
        Uri.parse(
            "https://pagalsong.in/uploads/systemuploads/mp3/Rab Ne Bana Di Jodi/Tujh Mein Rab Dikhta Hai - Rab Ne Bana Di Jodi 128 Kbps.mp3"),
        tag: MediaItem(
          id: "1",
          title: "Tujh Mein Rab Dikhta Hai",
          artist: "Shreya Ghosal, Salim - Sulaiman",
          artUri: Uri.parse(
              "https://c.saavncdn.com/344/Rab-Ne-Bana-Di-Jodi-Hindi-2008-500x500.jpg"),
        )),
    AudioSource.uri(
        Uri.parse(
            "https://pagalsong.in/uploads/systemuploads/mp3/Hum Dono (1961)/Abhi Na Jao Chhod Kar 128 Kbps.mp3"),
        tag: MediaItem(
          id: "2",
          title: "Abhi Na Jao Chhod Kar",
          artist: "Asha Bhosle, Mohammed Rafi",
          artUri: Uri.parse(
              "https://bajikaraoke.com/image/cache/catalog/karaoke/karaoke_2020/rafi/abhi_na_jao_chhod_kar-500x500.png"),
        )),
    AudioSource.uri(
        Uri.parse(
            "https://pagalsong.in/uploads/systemuploads/mp3/Airlift/Soch Na Sake.mp3"),
        tag: MediaItem(
          id: "3",
          title: "Soch na sake",
          artist: "Arijit Singh",
          artUri: Uri.parse(
              "https://i.scdn.co/image/ab67616d0000b2736b047c1401c8c18a54e4377d"),
        )),
    AudioSource.uri(
        Uri.parse(
            "https://pagalfree.com/musics/128-Pal - Monsoon Shootout 128 Kbps.mp3"),
        tag: MediaItem(
          id: "4",
          title: "Pal - Monsoon Shootout",
          artist: "Arijit Singh",
          artUri: Uri.parse(
              "https://is5-ssl.mzstatic.com/image/thumb/Music125/v4/08/04/59/08045948-152f-725f-d980-b43b1dd29e42/191773930202.jpg/600x600bf-60.jpg"),
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
