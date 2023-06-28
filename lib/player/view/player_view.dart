import 'package:audio_player/player/widgets/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerView extends StatelessWidget {
  final index;
  final duration;
  const PlayerView({Key? key, required this.index, required this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Music"),
        backgroundColor: Color(0xff1C1B1B),
        actions: [
          TextButton(
              onPressed: () {},
              child: SvgPicture.asset("assets/PlaylistAssets/options.svg"))
        ],
      ),
      backgroundColor: Color(0xff1C1B1B),
      body: Player(
        index: index,
        duration: duration,
      ),
    );
  }
}
