import 'package:at_your_home_partner/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrescriptionScreen extends StatefulWidget {
  final String imageUrl;
  const PrescriptionScreen({super.key, required this.imageUrl});

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double initialScaleFactor = screenWidth > screenHeight
        ? screenHeight / screenWidth
        : screenWidth / screenHeight;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: appBar,
          automaticallyImplyLeading: false,
          leadingWidth: MediaQuery.of(context).size.width,
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    arrowBackIc,
                    height: 26.h,
                    width: 26.w,
                  ),
                ),
                SizedBox(width: 13.w),
                Text(
                  "Prescription",
                  style: TextStyle(
                    color: whiteCl,
                    fontStyle: FontStyle.normal,
                    fontSize: 18.sp,
                    fontFamily: semiBold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(double.infinity),
          minScale: initialScaleFactor,
          maxScale: 5.0,
          scaleEnabled: true,
          constrained: false,
          child: Image.network(
            widget.imageUrl,
            width: screenWidth,
            height: screenHeight,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
