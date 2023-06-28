import 'package:audio_player/player/controller/player_controller.dart';
import 'package:audio_player/player/model/position_data.dart';
import 'package:audio_player/player/view/player_view.dart';
import 'package:audio_player/player/widgets/player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:marquee/marquee.dart';
import 'package:rxdart/rxdart.dart' as rx;

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);
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
    return SizedBox(
      height: 132.w,
      width: double.infinity,
      child: Column(
        children: [
          Obx(
            () => GestureDetector(
              onVerticalDragStart: (details) {
                Get.to(
                    () => PlayerView(
                          index: controller.currIndex.value,
                          duration: controller.currDur.value,
                        ),
                    curve: Curves.easeIn);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: Container(
                  height: 70.w,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    const Color(0xff3B3233).withOpacity(0.9),
                    const Color(0xff635758).withOpacity(0.9)
                  ], stops: const [
                    0.2,
                    0.9
                  ])),
                  padding: EdgeInsets.only(left: 20.w),
                  // child: Row(children: [
                  //   Container(
                  //     height: 40.w,
                  //     width: 40.w,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.all(Radius.circular(40.w)),
                  //         image: const DecorationImage(
                  //             image: AssetImage(
                  //                 "assets/PlaylistAssets/songCard.png"))),
                  //   ),
                  //   SvgPicture.asset("assets/PlaylistAssets/play.svg"),
                  // ]),
                  child: StreamBuilder<SequenceState?>(
                      stream: controller.audioPlayer.value.sequenceStateStream,
                      builder: (context, snapshot) {
                        final state = snapshot.data;
                        if (state?.sequence.isEmpty ?? true) {
                          return const SizedBox();
                        }
                        var data = state?.currentSource?.tag as MediaItem;
                        controller.currIndex.value = int.parse(data.id);
                        controller.currDur.value =
                            controller.audioPlayer.value.position;
                        return Row(children: [
                          Hero(
                            tag: "image",
                            transitionOnUserGestures: true,
                            child: SizedBox(
                              height: 50.w,
                              width: 50.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.w),
                                child: CachedNetworkImage(
                                  imageUrl: data.artUri.toString(),
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 110.w,
                                height: 25.w,
                                child: Marquee(
                                  scrollAxis: Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  velocity: 50.0,
                                  blankSpace: 10.w,
                                  pauseAfterRound: const Duration(seconds: 2),
                                  text: data.title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontSize: 12.w,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              SizedBox(
                                height: 25.w,
                                width: 110.w,
                                child: Marquee(
                                  scrollAxis: Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  velocity: 50.0,
                                  blankSpace: 10.w,
                                  pauseAfterRound: const Duration(seconds: 2),
                                  text: data.artist!,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontFamily: "Poppins",
                                    fontSize: 10.w,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 50.w,
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (controller.audioPlayer.value.loopMode ==
                                        LoopMode.all) {
                                      controller.loopMode.value =
                                          !controller.loopMode.value;
                                      controller.audioPlayer.value
                                          .setLoopMode(LoopMode.one);
                                    } else {
                                      controller.loopMode.value =
                                          !controller.loopMode.value;
                                      controller.audioPlayer.value
                                          .setLoopMode(LoopMode.all);
                                    }
                                  },
                                  child: Obx(() => SvgPicture.asset(
                                        controller.loopMode.value
                                            ? "assets/PlaylistAssets/repeat.svg"
                                            : "assets/PlaylistAssets/loopOne.svg",
                                        color: Colors.red,
                                      )),
                                ),
                                SvgPicture.asset(
                                    "assets/PlaylistAssets/heart.svg"),
                                StreamBuilder<PlayerState>(
                                    stream: controller
                                        .audioPlayer.value.playerStateStream,
                                    builder: (context, snapshot) {
                                      final playerState = snapshot.data;
                                      final processingState =
                                          playerState?.processingState;
                                      final playing = playerState?.playing;
                                      if (!(playing ?? false)) {
                                        return TextButton(
                                            onPressed: () {
                                              controller.audioPlayer.value
                                                  .play();
                                            },
                                            child: SvgPicture.asset(
                                                "assets/PlaylistAssets/play1.svg"));
                                      } else if (processingState !=
                                          ProcessingState.completed) {
                                        return TextButton(
                                            onPressed: () {
                                              controller.audioPlayer.value
                                                  .pause();
                                            },
                                            child: SvgPicture.asset(
                                                "assets/PlaylistAssets/pause.svg"));
                                      }
                                      return SvgPicture.asset(
                                          "assets/PlaylistAssets/play1.svg");
                                    }),
                              ],
                            ),
                          )
                        ]);
                      }),
                ),
              ),
            ),
          ),
          StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final position = snapshot.data;
                return ProgressBar(
                  barHeight: 2.w,
                  baseBarColor: Colors.white,
                  bufferedBarColor: Colors.grey[300],
                  progressBarColor: Colors.red,
                  thumbColor: Colors.red,
                  thumbRadius: 2.w,
                  progress: position?.position ?? Duration.zero,
                  total: position?.duration ?? Duration.zero,
                  buffered: position?.bufferedPosition ?? Duration.zero,
                  onSeek: (value) => controller.audioPlayer.value.seek(value),
                  barCapShape: BarCapShape.round,
                  timeLabelLocation: TimeLabelLocation.none,
                );
              }),
          Theme(
              data: ThemeData(canvasColor: const Color(0xff1C1B1B)),
              child: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/HomeAssets/home.svg",
                      fit: BoxFit.fitHeight,
                    ),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        "assets/HomeAssets/category.svg",
                      ),
                      label: "Category"),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        "assets/HomeAssets/search.svg",
                      ),
                      label: "Search"),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        "assets/HomeAssets/profile.svg",
                      ),
                      label: "Profile"),
                ],
                showUnselectedLabels: true,
              )),
        ],
      ),
    );
  }
}
