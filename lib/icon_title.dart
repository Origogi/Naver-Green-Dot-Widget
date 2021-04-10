import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IconTitle extends StatelessWidget {
  String _title;
  Widget _image;

  IconTitle(String title, Widget image) {
    _title = title;
    _image = image;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30,
          width: 30,
          child: FittedBox(
            fit: BoxFit.fill,
            child: _image,
            // child: Icon(
            //   _iconData,
            //   color: mintColor,
            // ),
          ),
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
