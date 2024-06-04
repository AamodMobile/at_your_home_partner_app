import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateServiceScreen extends StatefulWidget {
  const CreateServiceScreen({super.key});

  @override
  State<CreateServiceScreen> createState() => _CreateServiceScreenState();
}

class _CreateServiceScreenState extends State<CreateServiceScreen> {
  List<Map<String, dynamic>> categoryList = [
    {"title": "1 Day ", "value": "0"},
    {"title": "2 Day", "value": "1"},
    {"title": "3 Day", "value": "2"},
  ];
  var selectedCategory;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteCl,
        appBar: AppBar(
          backgroundColor: appBar,
          automaticallyImplyLeading: false,
          leadingWidth: MediaQuery.of(context).size.width,
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  "Add Service",
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create Service",
                          style: TextStyle(
                            color: appBar,
                            fontStyle: FontStyle.normal,
                            fontSize: 12.sp,
                            fontFamily: semiBold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Container(
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: appBar,
                            borderRadius: BorderRadius.circular(20)
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Available Time Slot",
                          style: TextStyle(
                            color: appBar,
                            fontStyle: FontStyle.normal,
                            fontSize: 12.sp,
                            fontFamily: semiBold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Container(
                          height: 8.h,
                          decoration: BoxDecoration(
                              color: Color(0xFFCEE9D1),
                              borderRadius: BorderRadius.circular(20)
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Image.asset(
                    hospitalIc,
                    height: 16.h,
                    width: 16.w,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "Category",
                    style: TextStyle(
                      color: mainColor,
                      fontStyle: FontStyle.normal,
                      fontSize: 12.sp,
                      fontFamily: regular,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              DropdownButtonHideUnderline(
                  child: DropdownButton2<String?>(
                    buttonStyleData: ButtonStyleData(
                      height: 45,
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: borderColorCont,
                        ),
                        color: Colors.white,
                      ),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: ImageIcon(
                        AssetImage(arrowDropDown),
                        size: 12,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      maxHeight: 200,
                      width: MediaQuery.of(context).size.width * 0.90,
                      useSafeArea: true,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all(6),
                        thumbVisibility: MaterialStateProperty.all(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 45,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                    isDense: true,
                    value: selectedCategory,
                    hint: const Text(
                      "Select Category",
                      style: TextStyle(fontWeight: FontWeight.w400, color: Color.fromRGBO(166, 166, 166, 0.7), fontFamily: regular, fontSize: 12, fontStyle: FontStyle.normal),
                    ),
                    style: const TextStyle(color: Colors.white60, fontSize: 13, fontWeight: FontWeight.bold),
                    isExpanded: true,
                    items: categoryList
                        .map((s) => DropdownMenuItem<String>(
                      value:s["title"],
                      child: Text(
                        s["title"],
                        style: const TextStyle(
                          fontFamily: regular,
                          color: blackCl,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ))
                        .toList(),
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          selectedCategory = value;
                        });
                      }
                    },
                  ),
                ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Image.asset(
                    hospitalIc,
                    height: 16.h,
                    width: 16.w,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "Sub-Category",
                    style: TextStyle(
                      color: mainColor,
                      fontStyle: FontStyle.normal,
                      fontSize: 12.sp,
                      fontFamily: regular,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              DropdownButtonHideUnderline(
                child: DropdownButton2<String?>(
                  buttonStyleData: ButtonStyleData(
                    height: 45,
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: borderColorCont,
                      ),
                      color: Colors.white,
                    ),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: ImageIcon(
                      AssetImage(arrowDropDown),
                      size: 12,
                    ),
                    iconSize: 14,
                    iconEnabledColor: Colors.black,
                    iconDisabledColor: Colors.grey,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    maxHeight: 200,
                    width: MediaQuery.of(context).size.width * 0.90,
                    useSafeArea: true,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                    ),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all(6),
                      thumbVisibility: MaterialStateProperty.all(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 45,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                  isDense: true,
                  value: selectedCategory,
                  hint: const Text(
                    "Select Category",
                    style: TextStyle(fontWeight: FontWeight.w400, color: Color.fromRGBO(166, 166, 166, 0.7), fontFamily: regular, fontSize: 12, fontStyle: FontStyle.normal),
                  ),
                  style: const TextStyle(color: Colors.white60, fontSize: 13, fontWeight: FontWeight.bold),
                  isExpanded: true,
                  items: categoryList
                      .map((s) => DropdownMenuItem<String>(
                    value:s["title"],
                    child: Text(
                      s["title"],
                      style: const TextStyle(
                        fontFamily: regular,
                        color: blackCl,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ))
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        selectedCategory = value;
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Image.asset(
                    hospitalIc,
                    height: 16.h,
                    width: 16.w,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "Service",
                    style: TextStyle(
                      color: mainColor,
                      fontStyle: FontStyle.normal,
                      fontSize: 12.sp,
                      fontFamily: regular,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              DropdownButtonHideUnderline(
                child: DropdownButton2<String?>(
                  buttonStyleData: ButtonStyleData(
                    height: 45,
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: borderColorCont,
                      ),
                      color: Colors.white,
                    ),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: ImageIcon(
                      AssetImage(arrowDropDown),
                      size: 12,
                    ),
                    iconSize: 14,
                    iconEnabledColor: Colors.black,
                    iconDisabledColor: Colors.grey,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    maxHeight: 200,
                    width: MediaQuery.of(context).size.width * 0.90,
                    useSafeArea: true,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                    ),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all(6),
                      thumbVisibility: MaterialStateProperty.all(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 45,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                  isDense: true,
                  value: selectedCategory,
                  hint: const Text(
                    "Select Category",
                    style: TextStyle(fontWeight: FontWeight.w400, color: Color.fromRGBO(166, 166, 166, 0.7), fontFamily: regular, fontSize: 12, fontStyle: FontStyle.normal),
                  ),
                  style: const TextStyle(color: Colors.white60, fontSize: 13, fontWeight: FontWeight.bold),
                  isExpanded: true,
                  items: categoryList
                      .map((s) => DropdownMenuItem<String>(
                    value:s["title"],
                    child: Text(
                      s["title"],
                      style: const TextStyle(
                        fontFamily: regular,
                        color: blackCl,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ))
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        selectedCategory = value;
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Add images Patient",
                style: TextStyle(
                  color: blackCl,
                  fontStyle: FontStyle.normal,
                  fontSize: 14.sp,
                  fontFamily: semiBold,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16.h),

            ],
          ),
        ),
        bottomSheet: Container(
          color: lightFillCl,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 15.h),
          child: Wrap(
            children: [
              SizedBox(
                height: 43.h,
                child: CustomButtonWidget(
                  padding: EdgeInsets.zero,
                  style: CustomButtonStyle.style2,
                  onPressed: () {

                  },
                  text: 'Submit',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
