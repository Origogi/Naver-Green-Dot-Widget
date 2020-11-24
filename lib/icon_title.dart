import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_dot/constants.dart';

class IconTitle extends StatelessWidget {
  String _title;
  IconData _iconData;

  IconTitle(String title, IconData iconData) {
    _title = title;
    _iconData = iconData;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          _iconData,
          size: 30,
          color: mintColor,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          _title,
          style: GoogleFonts.nanumGothic(
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
