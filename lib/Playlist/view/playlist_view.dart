import 'package:audio_player/Playlist/widget/tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlaylistView extends StatelessWidget {
  const PlaylistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1C1B1B),
        title: const Text("Music"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        centerTitle: true,
      ),
      drawer: const Drawer(),
      backgroundColor: const Color(0xff1C1B1B),
      bottomNavigationBar: Theme(
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
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20.w),
                foregroundDecoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff1C1B1B),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0, 0.05],
                  ),
                ),
                child: Image.asset("assets/PlaylistAssets/shreya.png"),
              ),
              Positioned(
                bottom: 20.w,
                left: 20.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Shreya’s Hit Mix",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 20.w),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.w),
                      height: 50.w,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        softWrap: true,
                        "Description - Lorem Ipsum dummy text htiw on esens esaelp erongi",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            fontSize: 12.w),
                      ),
                    ),
                    Text(
                      "20:45 min",
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                          fontSize: 12.w),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 80.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset("assets/PlaylistAssets/download.svg"),
                      SvgPicture.asset("assets/PlaylistAssets/options.svg"),
                    ],
                  ),
                ),
                SizedBox(
                  width: 180.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset("assets/PlaylistAssets/like.svg"),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffEA3800),
                            minimumSize: Size(110.w, 45.w),
                            maximumSize: Size(110.w, 45.w),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.w))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset("assets/PlaylistAssets/play.svg"),
                            Text(
                              "Play",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 18.w),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.w,
          ),
          Expanded(
              child: ListView(
            children: const [
              Tiles(),
              Tiles(),
              Tiles(),
              Tiles(),
              Tiles(),
              Tiles(),
              Tiles(),
            ],
          ))
        ],
      ),
    );
  }
}
