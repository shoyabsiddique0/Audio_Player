import 'package:audio_player/player/controller/player_controller.dart';
import 'package:audio_player/player/model/media_item.dart';
import 'package:audio_player/player/model/position_data.dart';
import 'package:audio_player/player/widgets/controls.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rx;

// ignore: must_be_immutable
class Player extends StatelessWidget {
  Player({Key? key}) : super(key: key);
  PlayerController controller = Get.put(PlayerController());
  Stream<PositionData> get _positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        controller.audioPlayer.value.positionStream,
        controller.audioPlayer.value.bufferedPositionStream,
        controller.audioPlayer.value.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StreamBuilder<SequenceState?>(
              stream: controller.audioPlayer.value.sequenceStateStream,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state?.sequence.isEmpty ?? true) {
                  return const SizedBox();
                }
                final metadata = state!.currentSource!.tag as MediaItem;
                return Container(
                  margin: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: const Color(0x38EA3800),
                            blurRadius: 10.w,
                            spreadRadius: 2.w,
                          )
                        ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            metadata.artUri,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            metadata.title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.w,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w800),
                          ),
                          SvgPicture.asset("assets/PlaylistAssets/heart.svg")
                        ],
                      ),
                      SizedBox(
                        height: 2.w,
                      ),
                      Text(
                        metadata.artist,
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.w,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              }),
          SizedBox(
            height: 30.w,
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final position = snapshot.data;
                  return Container(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Stack(
                      children: [
                        ProgressBar(
                          barHeight: 3.w,
                          baseBarColor: Colors.white,
                          bufferedBarColor: Colors.grey[300],
                          progressBarColor: Colors.red,
                          thumbColor: Colors.red,
                          thumbRadius: 5.w,
                          progress: position?.position ?? Duration.zero,
                          total: position?.duration ?? Duration.zero,
                          buffered: position?.bufferedPosition ?? Duration.zero,
                          onSeek: (value) =>
                              controller.audioPlayer.value.seek(value),
                          timeLabelTextStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 12.w),
                          barCapShape: BarCapShape.round,
                          timeLabelPadding: 10.w,
                          timeLabelType: TimeLabelType.totalTime,
                        ),
                        Obx(
                          () => Stack(
                            fit: StackFit.passthrough,
                            children: controller.bookmarks.map((bookmark) {
                              double bookmarkPosition =
                                  bookmark.inSeconds.toDouble();
                              double bookmarkWidth = (bookmarkPosition /
                                          controller.audioPlayer.value.duration!
                                              .inSeconds
                                              .toDouble()) *
                                      MediaQuery.of(context).size.width -
                                  10;
                              return GestureDetector(
                                onTap: () {
                                  controller.audioPlayer.value.seek(bookmark);
                                },
                                child: Container(
                                  width: 5.0,
                                  height: 20.0,
                                  color: Colors.red, // Bookmark marker color
                                  margin: EdgeInsets.only(left: bookmarkWidth),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  );
                }),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    controller.audioPlayer.value.seek(
                        controller.audioPlayer.value.position -
                            const Duration(seconds: 10));
                  },
                  child: SvgPicture.asset(
                    "assets/PlaylistAssets/10rev.svg",
                  ),
                ),
                TextButton(
                    onPressed: () {
                      controller.audioPlayer.value.seekToPrevious();
                    },
                    child: SvgPicture.asset(
                      "assets/PlaylistAssets/back.svg",
                    )),
                Controls(audioPlayer: controller.audioPlayer.value),
                TextButton(
                    onPressed: () {
                      controller.audioPlayer.value.seekToNext();
                    },
                    child: SvgPicture.asset(
                      "assets/PlaylistAssets/forward.svg",
                    )),
                TextButton(
                    onPressed: () {
                      controller.audioPlayer.value.seek(
                          controller.audioPlayer.value.position +
                              const Duration(seconds: 10));
                    },
                    child: SvgPicture.asset(
                      "assets/PlaylistAssets/10for.svg",
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        if (controller.audioPlayer.value.loopMode ==
                            LoopMode.off) {
                          controller.loopMode.value =
                              !controller.loopMode.value;
                          controller.audioPlayer.value
                              .setLoopMode(LoopMode.all);
                        } else {
                          controller.loopMode.value =
                              !controller.loopMode.value;
                          controller.audioPlayer.value
                              .setLoopMode(LoopMode.off);
                        }
                      },
                      child: Obx(() => SvgPicture.asset(
                            "assets/PlaylistAssets/repeat.svg",
                            theme: SvgTheme(
                              currentColor: controller.loopMode.value
                                  ? Colors.white
                                  : Colors.red,
                            ),
                          )),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.bottomSheet(Container(
                          color: Colors.black54,
                          height: 280.h,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10.w, top: 20.w),
                                      width: 180.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SvgPicture.asset(
                                              "assets/PlaylistAssets/playback.svg"),
                                          Text(
                                            "PlayBack Speed",
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 18.w,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: 10.w, top: 20.w),
                                      child: TextButton(
                                          onPressed: () => Get.back(),
                                          child: SvgPicture.asset(
                                              "assets/PlaylistAssets/close.svg")),
                                    )
                                  ],
                                ),
                                Obx(
                                  () => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                          onTap: () {
                                            controller.audioPlayer.value
                                                .setSpeed(0.25);
                                            controller.playback.value = 1;
                                          },
                                          title: Text(
                                            "0.25x",
                                            style: TextStyle(
                                                color: controller
                                                            .playback.value ==
                                                        1
                                                    ? const Color(0xffC02739)
                                                    : Colors.white),
                                          )),
                                      ListTile(
                                          onTap: () {
                                            controller.playback.value = 2;
                                            controller.audioPlayer.value
                                                .setSpeed(0.5);
                                          },
                                          title: Text("0.5x",
                                              style: TextStyle(
                                                  color: controller
                                                              .playback.value ==
                                                          2
                                                      ? const Color(0xffC02739)
                                                      : Colors.white))),
                                      ListTile(
                                          onTap: () {
                                            controller.playback.value = 3;
                                            controller.audioPlayer.value
                                                .setSpeed(0.75);
                                          },
                                          title: Text("0.75x",
                                              style: TextStyle(
                                                  color: controller
                                                              .playback.value ==
                                                          3
                                                      ? const Color(0xffC02739)
                                                      : Colors.white))),
                                      ListTile(
                                          onTap: () {
                                            controller.playback.value = 4;
                                            controller.audioPlayer.value
                                                .setSpeed(1);
                                          },
                                          title: Text("Normal",
                                              style: TextStyle(
                                                  color: controller
                                                              .playback.value ==
                                                          4
                                                      ? const Color(0xffC02739)
                                                      : Colors.white))),
                                      ListTile(
                                          onTap: () {
                                            controller.audioPlayer.value
                                                .setSpeed(1.25);
                                            controller.playback.value = 5;
                                          },
                                          title: Text("1.25x",
                                              style: TextStyle(
                                                  color: controller
                                                              .playback.value ==
                                                          5
                                                      ? const Color(0xffC02739)
                                                      : Colors.white))),
                                      ListTile(
                                          onTap: () {
                                            controller.playback.value = 6;
                                            controller.audioPlayer.value
                                                .setSpeed(1.5);
                                          },
                                          title: Text("1.5x",
                                              style: TextStyle(
                                                  color: controller
                                                              .playback.value ==
                                                          6
                                                      ? const Color(0xffC02739)
                                                      : Colors.white))),
                                      ListTile(
                                          onTap: () {
                                            controller.playback.value = 7;
                                            controller.audioPlayer.value
                                                .setSpeed(1.75);
                                          },
                                          title: Text("1.75x",
                                              style: TextStyle(
                                                  color: controller
                                                              .playback.value ==
                                                          7
                                                      ? const Color(0xffC02739)
                                                      : Colors.white))),
                                      ListTile(
                                          onTap: () {
                                            controller.playback.value = 8;
                                            controller.audioPlayer.value
                                                .setSpeed(2);
                                          },
                                          title: Text("2x",
                                              style: TextStyle(
                                                  color: controller
                                                              .playback.value ==
                                                          8
                                                      ? const Color(0xffC02739)
                                                      : Colors.white))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                      },
                      child: SvgPicture.asset(
                        "assets/PlaylistAssets/playback.svg",
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          if (controller.muteVal.value) {
                            controller.audioPlayer.value.setVolume(1.0);
                            controller.muteVal.value = false;
                          } else {
                            controller.audioPlayer.value.setVolume(0.0);
                            controller.muteVal.value = true;
                          }
                        },
                        child: Obx(
                          () => SvgPicture.asset(
                            controller.muteVal.value
                                ? "assets/PlaylistAssets/mute.svg"
                                : "assets/PlaylistAssets/volume.svg",
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          controller.bookmarks
                              .add(controller.audioPlayer.value.position);
                        },
                        child: SvgPicture.asset(
                          "assets/PlaylistAssets/bookmark.svg",
                        )),
                  ],
                )
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
