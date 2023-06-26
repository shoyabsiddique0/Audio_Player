import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardHome extends StatelessWidget {
  final String link;
  final String name;
  final String duration;
  final void Function() func;
  CardHome(
      {Key? key,
      required this.link,
      required this.name,
      required this.duration,
      required this.func})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            link,
            width: 130.w,
          ),
          Text(
            name,
            style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
          ),
          Text(
            duration,
            style: TextStyle(color: Colors.white70, fontFamily: "Poppins"),
          ),
        ],
      ),
    );
  }
}
