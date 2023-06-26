import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Tiles extends StatelessWidget {
  const Tiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        "assets/PlaylistAssets/songCard.png",
        width: 80.w,
        height: 80.w,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Tujh Mein Rab Dikhta hai",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18.w),
          ),
          SvgPicture.asset("assets/PlaylistAssets/options.svg")
        ],
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shreya Ghosal, Salim - Sulaiman",
            style: TextStyle(color: Colors.white, fontSize: 12.w),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "4:41 ",
                style: TextStyle(color: Colors.white, fontSize: 15.w),
              ),
              SvgPicture.asset("assets/PlaylistAssets/heart.svg"),
            ],
          )
        ],
      ),
    );
  }
}
