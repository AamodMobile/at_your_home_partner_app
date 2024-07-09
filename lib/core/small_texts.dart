

import 'package:at_your_home_partner/constants/constants.dart';
import 'package:flutter_html/flutter_html.dart';

class SmallTexts extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  final int? maxline;

  const SmallTexts(
      {super.key,
      this.color = const Color(0xFFccc7c5),
      required this.text,
      this.size = 10.0,
      this.height = 0.2,
      this.maxline});

  @override
  Widget build(BuildContext context) {
    return
    /*  Text(
      text,
      maxLines: maxline,
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: size,
          fontStyle: FontStyle.normal,
          fontFamily: regular,
          color: color),
    );*/

    Html(
      data:text,
      shrinkWrap: true,
      style: {
        "body": Style(
          fontSize: FontSize(10.0),
          fontWeight: FontWeight.w600,
          fontFamily: regular,
          color: color,
        ),
      },
    );
  }
}
