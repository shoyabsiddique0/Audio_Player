import 'package:audio_player/Home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';

Future<void> main() async {
  await JustAudioBackground.init(
      androidNotificationChannelId:
          'com.ryanheise.audioservice.AudioServiceActivity',
      androidNotificationChannelName: "Music",
      androidNotificationOngoing: true);
  runApp(ScreenUtilInit(builder: (context, child) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }));
}
