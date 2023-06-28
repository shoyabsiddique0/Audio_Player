import 'package:audio_player/BottomNav/bottom_nav_bar.dart';
import 'package:audio_player/Home/controller/home_controller.dart';
import 'package:audio_player/Home/widget/card.dart';
import 'package:audio_player/Playlist/view/playlist_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  HomeController homeController = Get.put(HomeController());
  CarouselController _controller = CarouselController();
  List<Widget> suggestionList = [
    Image.asset("assets/HomeAssets/suggestionCard.png"),
    Image.asset("assets/HomeAssets/suggestionCard.png"),
    Image.asset("assets/HomeAssets/suggestionCard.png"),
    Image.asset("assets/HomeAssets/suggestionCard.png"),
    Image.asset("assets/HomeAssets/suggestionCard.png"),
  ];
  List<Widget> trendingList = [
    CardHome(
      link: "assets/HomeAssets/arijit.png",
      name: "Soulful Arijit",
      duration: "20:45 mins",
      func: () => Get.to(() => PlaylistView()),
    ),
    CardHome(
      link: "assets/HomeAssets/arijit.png",
      name: "Soulful Arijit",
      duration: "20:45 mins",
      func: () => Get.to(() => PlaylistView()),
    ),
    CardHome(
      link: "assets/HomeAssets/arijit.png",
      name: "Soulful Arijit",
      duration: "20:45 mins",
      func: () => Get.to(() => PlaylistView()),
    ),
    CardHome(
      link: "assets/HomeAssets/arijit.png",
      name: "Soulful Arijit",
      duration: "20:45 mins",
      func: () => Get.to(() => PlaylistView()),
    ),
  ];
  List<Widget> featuredList = [
    CardHome(
        link: "assets/HomeAssets/kk.png",
        name: "It’s gonna be KK",
        duration: "20:45 mins",
        func: () => Get.to(() => PlaylistView())),
    CardHome(
        link: "assets/HomeAssets/kk.png",
        name: "It’s gonna be KK",
        duration: "20:45 mins",
        func: () => Get.to(() => PlaylistView())),
    CardHome(
        link: "assets/HomeAssets/kk.png",
        name: "It’s gonna be KK",
        duration: "20:45 mins",
        func: () => Get.to(() => PlaylistView())),
    CardHome(
        link: "assets/HomeAssets/kk.png",
        name: "It’s gonna be KK",
        duration: "20:45 mins",
        func: () => Get.to(() => PlaylistView())),
  ];
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
      bottomNavigationBar: BottomNavBar(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          CarouselSlider(
            items: suggestionList,
            options: CarouselOptions(
                aspectRatio: 330.w / 340.w,
                // ScreenUtil.defaultSize.width *
                // 1.8 /
                // ScreenUtil.defaultSize.height,
                viewportFraction: 0.75.w,
                enlargeCenterPage: true,
                padEnds: true,
                onPageChanged: (index, reason) {
                  homeController.current.value = index;
                }),
            carouselController: _controller,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: suggestionList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 6.0.w,
                      height: 6.0.w,
                      margin: EdgeInsets.symmetric(horizontal: 4.0.w),
                      decoration: BoxDecoration(
                          shape: homeController.current.value == entry.key
                              ? BoxShape.rectangle
                              : BoxShape.circle,
                          color:
                              (Theme.of(context).brightness == Brightness.dark
                                      ? const Color(0xffD6B5BB)
                                      : const Color(0xffE41238))
                                  .withOpacity(
                                      homeController.current.value == entry.key
                                          ? 0.9
                                          : 0.4)),
                    ),
                  );
                }).toList(),
              )),
          Container(
            padding: EdgeInsets.only(left: ScreenUtil.defaultSize.width * 0.05),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "Trending Podcast",
                          style: TextStyle(
                            fontSize: ScreenUtil.defaultSize.width * 0.05,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ))),
                  TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              CarouselSlider(
                  items: trendingList,
                  options: CarouselOptions(
                      aspectRatio: 1.6.w,
                      viewportFraction: 0.42.w,
                      enableInfiniteScroll: false,
                      padEnds: false)),
            ]),
          ),
          Container(
            padding: EdgeInsets.only(left: ScreenUtil.defaultSize.width * 0.05),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "Featured Podcast",
                          style: TextStyle(
                            fontSize: ScreenUtil.defaultSize.width * 0.05,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ))),
                  TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              CarouselSlider(
                  items: featuredList,
                  options: CarouselOptions(
                      aspectRatio: 1.6.w,
                      viewportFraction: 0.42.w,
                      enableInfiniteScroll: false,
                      padEnds: false)),
            ]),
          ),
        ],
      )),
    );
  }
}
