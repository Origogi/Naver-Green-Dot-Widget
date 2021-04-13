import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IconTitleData {
  final String imageUri;
  final String title;

  IconTitleData(this.imageUri, this.title);
}

class OuterIconTitle extends StatelessWidget {
  String _title;
  Widget _image;
  double _opacity;

  OuterIconTitle(String title, Widget image, double opacity) {
    _title = title;
    _image = image;
    _opacity = opacity;
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _opacity,
      child: Column(
        children: [
          Container(
            height: 35,
            width: 35,
            child: FittedBox(
              fit: BoxFit.fill,
              child: _image,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            _title,
            style: GoogleFonts.nanumGothic(
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}

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
          height: 35,
          width: 35,
          child: FittedBox(
            fit: BoxFit.fill,
            child: _image,
          ),
        ),
        SizedBox(
          height: 10,
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
