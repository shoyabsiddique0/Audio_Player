import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class PlayerController extends GetxController {
  final audioPlayer = AudioPlayer().obs;
  final loopMode = true.obs;
  final mute = false.obs;
  final RxMap<String, List<Duration>> bookmarks =
      <String, List<Duration>>{}.obs;
  final volume = 1.0.obs;
  final muteVal = false.obs;
  final playback = 4.obs;
  final currPos = 0.0.obs;
  var width = 0.0.obs;
  var startPos = Offset(0, 0).obs;
  var endPos = Offset(0, 0).obs;
  var mywidgetkey = GlobalKey().obs;
  var metaData = MediaItem(id: "", title: "").obs;
  final currIndex = 0.obs;
  final currDur = Duration.zero.obs;
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
            duration: const Duration(minutes: 4, seconds: 45))),
    AudioSource.uri(
        Uri.parse(
            "https://pagalsong.in/uploads/systemuploads/mp3/Hum Dono (1961)/Abhi Na Jao Chhod Kar 128 Kbps.mp3"),
        tag: MediaItem(
            id: "2",
            title: "Abhi Na Jao Chhod Kar",
            artist: "Asha Bhosle, Mohammed Rafi",
            artUri: Uri.parse(
                "https://bajikaraoke.com/image/cache/catalog/karaoke/karaoke_2020/rafi/abhi_na_jao_chhod_kar-500x500.png"),
            duration: const Duration(minutes: 4, seconds: 45))),
    AudioSource.uri(
        Uri.parse(
            "https://pagalsong.in/uploads/systemuploads/mp3/Airlift/Soch Na Sake.mp3"),
        tag: MediaItem(
            id: "3",
            title: "Soch na sake",
            artist: "Arijit Singh",
            artUri: Uri.parse(
                "https://i.scdn.co/image/ab67616d0000b2736b047c1401c8c18a54e4377d"),
            duration: const Duration(minutes: 4, seconds: 45))),
    AudioSource.uri(
        Uri.parse(
            "https://pagalfree.com/musics/128-Pal - Monsoon Shootout 128 Kbps.mp3"),
        tag: MediaItem(
            id: "4",
            title: "Pal - Monsoon Shootout",
            artist: "Arijit Singh",
            artUri: Uri.parse(
                "https://is5-ssl.mzstatic.com/image/thumb/Music125/v4/08/04/59/08045948-152f-725f-d980-b43b1dd29e42/191773930202.jpg/600x600bf-60.jpg"),
            duration: const Duration(minutes: 4, seconds: 45))),
  ]);
  @override
  void onInit() {
    // ignore: avoid_function_literals_in_foreach_calls
    playlist.children.forEach((element) =>
        bookmarks["${playlist.children.indexOf(element) + 1}"] = <Duration>[]);
    _init();
    super.onInit();
  }

  void _init() async {
    await audioPlayer.value.setLoopMode(LoopMode.all);
    await audioPlayer.value
        .setAudioSource(playlist, initialIndex: 0, preload: true);
  }

  @override
  void onClose() {
    audioPlayer.value.dispose();
    super.onClose();
  }

  void changeIndex(currIndex, duration) async {
    await audioPlayer.value.setAudioSource(playlist,
        initialIndex: currIndex, preload: true, initialPosition: duration);
  }

  void findWidth(GlobalKey widgetkey) {
    var box = widgetkey.currentContext?.findRenderObject() as RenderBox;
    width.value = box.size.width;
  }

  List<Widget> getBookmarks(metaData, position, widgetkey) {
    try {
      List<Widget> data = bookmarks[metaData?.id]!.map((bookmark) {
        findWidth(widgetkey);
        double bookmarkPosition = bookmark.inSeconds.toDouble();
        double bookmarkWidth = (bookmarkPosition /
                audioPlayer.value.duration!.inSeconds.toDouble()) *
            width.value;
        return GestureDetector(
          onTap: () => audioPlayer.value.seek(bookmark),
          child: Container(
            width: 11.5.w,
            height: 20.0,
            margin: EdgeInsets.only(left: bookmarkWidth),
            // decoration: const BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage(
            //             "assets/PlaylistAssets/pin.png"))),
            child: SvgPicture.asset("assets/PlaylistAssets/pin.svg",
                // color: bookmark.inSeconds >=
                //         position!.position.inSeconds
                //     ? Colors.white
                //     : Colors.red,
                theme: SvgTheme(
                  currentColor:
                      bookmark.inSeconds >= position!.position.inSeconds
                          ? Colors.white
                          : Colors.red,
                )),
          ),
        );
      }).toList();
      return data;
    } catch (e) {
      return [];
    }
  }
}
