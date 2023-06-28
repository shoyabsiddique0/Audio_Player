import 'package:audio_player/player/view/player_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Tiles extends StatelessWidget {
  final String name;
  final String artist;
  final Uri image;
  final Duration duration;

  final int index;
  const Tiles(
      {Key? key,
      required this.name,
      required this.artist,
      required this.image,
      required this.duration,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 6.w),
      child: ListTile(
        onTap: () => Get.to(() => PlayerView(
              index: index,
              duration: Duration.zero,
            )),
        leading: CachedNetworkImage(
          imageUrl: image.toString(),
          width: 80.w,
          height: 80.w,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.w),
            ),
            SvgPicture.asset("assets/PlaylistAssets/options.svg")
          ],
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              artist,
              style: TextStyle(color: Colors.white, fontSize: 12.w),
            ),
            SizedBox(
              height: 6.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${duration.inMinutes}:${duration.inSeconds % 60}",
                  style: TextStyle(color: Colors.white, fontSize: 15.w),
                ),
                SvgPicture.asset("assets/PlaylistAssets/heart.svg"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
