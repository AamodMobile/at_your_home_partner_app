import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/core/small_texts.dart';


class ExpandableTextWidget extends StatefulWidget {
  final String text;

  const ExpandableTextWidget({super.key, required this.text});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 5.63;

  // i  love flutter laravel and golang 30
  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallTexts(
              color: blackCl, size: 10, text: firstHalf)
          : Column(
              children: [
                SmallTexts(
                    height: 1.0,
                    color: blackCl,
                    size: 10,
                    text: hiddenText
                        ? ("$firstHalf...")
                        : (firstHalf + secondHalf)),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SmallTexts(
                        text: hiddenText ? "Show more" : "Show less",
                        color: hiddenText ? mainColor : cancelBorderCl,
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
