import 'dart:io';

import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/add_service_controller.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:at_your_home_partner/model/all_category_list_model.dart';
import 'package:at_your_home_partner/model/service_list_model.dart';
import 'package:at_your_home_partner/model/sub_category_list_model.dart';
import 'package:at_your_home_partner/model/time_slot_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CreateServiceScreen extends StatefulWidget {
  const CreateServiceScreen({super.key});

  @override
  State<CreateServiceScreen> createState() => _CreateServiceScreenState();
}

class _CreateServiceScreenState extends State<CreateServiceScreen> {
  AddServiceController controller = Get.put(AddServiceController());
  int selectedTimeSlot = 0;
  late Map<DateTime, List<TimeSlotData>> timeSlots;

  DateTime selectedDate = DateTime.now();
  List<TimeSlotData> selectedTimeSlots = [];

  Map<DateTime, List<TimeSlotData>> selectedTimeSlotsMap = {};

  void _updateSelectedDate(DateTime date) {
    setState(() {
      selectedDate = date;
      selectedTimeSlots = selectedTimeSlotsMap[date] ?? [];
    });
  }

  void _toggleTimeSlot(TimeSlotData timeSlot) {
    setState(() {
      if (selectedTimeSlots.contains(timeSlot)) {
        selectedTimeSlots.remove(timeSlot);
      } else {
        selectedTimeSlots.add(timeSlot);
      }
      selectedTimeSlotsMap[selectedDate] = selectedTimeSlots;
    });
  }

  @override
  void initState() {
    controller.reset();
    controller.timeSlotsListGet().then((value) {
      timeSlots = {};
      for (int i = 0; i < 7; i++) {
        DateTime date = DateTime.now().add(Duration(days: i));
        timeSlots[date] = controller.timeSlotList;
      }
    });

    controller.patientImages.clear();
    controller.patientImages.add("upload");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<AddServiceController>(),
        initState: (state) {
          Get.find<AddServiceController>().allCategoryListGet();
        },
        builder: (contextCtr) {
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
                          if (selectedTimeSlot == 1) {
                            setState(() {
                              selectedTimeSlot = 0;
                            });
                          } else {
                            Get.back();
                          }
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
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTimeSlot = 0;
                              });
                            },
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
                                  decoration: BoxDecoration(color: appBar, borderRadius: BorderRadius.circular(20)),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTimeSlot = 1;
                              });
                            },
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
                                  decoration: BoxDecoration(color: selectedTimeSlot == 1 ? appBar : const Color(0xFFCEE9D1), borderRadius: BorderRadius.circular(20)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    selectedTimeSlot == 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                              Obx(
                                () => DropdownButtonHideUnderline(
                                  child: DropdownButton2<AllCategoryListModel?>(
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
                                    value: contextCtr.allCategoryListModel,
                                    hint: const Text(
                                      "Select Category",
                                      style: TextStyle(fontWeight: FontWeight.w400, color: Color.fromRGBO(166, 166, 166, 0.7), fontFamily: regular, fontSize: 12, fontStyle: FontStyle.normal),
                                    ),
                                    style: const TextStyle(color: Colors.white60, fontSize: 13, fontWeight: FontWeight.bold),
                                    isExpanded: true,
                                    items: contextCtr.allCategoryList
                                        .map((s) => DropdownMenuItem<AllCategoryListModel>(
                                              value: s,
                                              child: Text(
                                                "${s.label}",
                                                style: const TextStyle(
                                                  fontFamily: regular,
                                                  color: blackCl,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (AllCategoryListModel? value) {
                                      if (value != null) {
                                        setState(() {
                                          contextCtr.allCategoryListModel = value;
                                          contextCtr.subCategoryListGet(contextCtr.allCategoryListModel.value.toString());
                                        });
                                      }
                                    },
                                  ),
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
                              Obx(
                                () => DropdownButtonHideUnderline(
                                  child: DropdownButton2<SubCategoryListModel?>(
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
                                    value: contextCtr.subCategoryListModel,
                                    hint: const Text(
                                      "Select Sub-Category",
                                      style: TextStyle(fontWeight: FontWeight.w400, color: Color.fromRGBO(166, 166, 166, 0.7), fontFamily: regular, fontSize: 12, fontStyle: FontStyle.normal),
                                    ),
                                    style: const TextStyle(color: Colors.white60, fontSize: 13, fontWeight: FontWeight.bold),
                                    isExpanded: true,
                                    items: contextCtr.subCategoryList
                                        .map((s) => DropdownMenuItem<SubCategoryListModel>(
                                              value: s,
                                              child: Text(
                                                s.label.toString(),
                                                style: const TextStyle(
                                                  fontFamily: regular,
                                                  color: blackCl,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (SubCategoryListModel? value) {
                                      if (value != null) {
                                        setState(() {
                                          contextCtr.subCategoryListModel = value;
                                          contextCtr.serviceListGet(contextCtr.allCategoryListModel.value.toString(), contextCtr.subCategoryListModel.value.toString());
                                        });
                                      }
                                    },
                                  ),
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
                              CustomMultiSelectDropdown(
                                items: controller.serviceList,
                                selectedItems: controller.selectedServiceList,
                                onChanged: (selectedItems) {
                                  setState(() {
                                    controller.selectedServiceList.value = selectedItems;
                                  });
                                },
                                controller: contextCtr,
                              ),
                              /*  Obx(() {
                                return DropdownButtonHideUnderline(
                                  child: DropdownButton2<ServiceListModel>(
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
                                    hint: const Text(
                                      "Select Services",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(166, 166, 166, 0.7),
                                        fontFamily: regular,
                                        fontSize: 12,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    style: const TextStyle(color: Colors.white60, fontSize: 13, fontWeight: FontWeight.bold),
                                    isExpanded: true,
                                    items: controller.serviceList.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: StatefulBuilder(
                                          builder: (context, menuSetState) {
                                            final isSelected = controller.selectedService.contains(item.value.toString());
                                            return InkWell(
                                              onTap: () {
                                                if (isSelected) {
                                                  controller.selectedService.remove(item.value.toString());
                                                  controller.selectedServiceList.remove(item);
                                                } else {
                                                  controller.selectedService.add(item.value.toString());
                                                  controller.selectedServiceList.add(item);
                                                }
                                                menuSetState(() {});
                                              },
                                              child: Container(
                                                height: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                child: Row(
                                                  children: [
                                                    isSelected
                                                        ? const Icon(
                                                            Icons.check_box_outlined,
                                                            color: mainColor,
                                                          )
                                                        : const Icon(Icons.check_box_outline_blank),
                                                    const SizedBox(width: 16),
                                                    Expanded(
                                                      child: Text(
                                                        item.label.toString(),
                                                        style: TextStyle(
                                                          fontFamily: regular,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          color: isSelected ? mainColor : blackCl,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }).toList(),
                                    value: controller.selectedServiceList.isEmpty ? null : controller.selectedServiceList.last,
                                    // Remove .last
                                    onChanged: (value) {
                                      // No need to handle onChanged as we manage selection in onTap
                                    },
                                    selectedItemBuilder: (context) {
                                      // Custom display of selected items
                                      if (controller.selectedServiceList.isNotEmpty) {
                                        return controller.selectedServiceList.map((item) {
                                          return Container(
                                            alignment: AlignmentDirectional.center,
                                            child: Text(
                                              item.label.toString(),
                                              style: const TextStyle(
                                                fontFamily: 'regular',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: blackCl,
                                              ),
                                            ),
                                          );
                                        }).toList();
                                      } else {
                                        return [Container()]; // Return an empty list or widget if nothing selected
                                      }
                                    },
                                  ),
                                );
                              }),*/
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
                              SizedBox(
                                height: 78,
                                width: MediaQuery.of(context).size.width,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: ListView.builder(
                                    clipBehavior: Clip.none,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: contextCtr.patientImages.length,
                                    reverse: true,
                                    itemBuilder: (BuildContext context, int index) {
                                      if (contextCtr.patientImages[index] == "upload") {
                                        return GestureDetector(
                                          onTap: () {
                                            if (contextCtr.patientImages[index] == "upload") {
                                              contextCtr.selectImages().then((value) {
                                                setState(() {});
                                              });
                                            }
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(left: 9),
                                            clipBehavior: Clip.antiAlias,
                                            height: 78,
                                            width: 74,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(7),
                                            ),
                                            child: Center(
                                              child: Image.asset(uploadImg, fit: BoxFit.contain),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          margin: const EdgeInsets.only(left: 9),
                                          height: 78,
                                          width: 74,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: mainColor, width: 1),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.file(File(contextCtr.patientImages[index].path), fit: BoxFit.cover),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Builder(builder: (context) {
                            if (contextCtr.isLoading.value) {
                              return Center(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height - 200,
                                  width: 400,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: mainColor,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      dateRangeIc,
                                      height: 16.h,
                                      width: 16.w,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "Select Date",
                                      style: TextStyle(
                                        color: mainColor,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12.sp,
                                        fontFamily: semiBold,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),
                                SizedBox(
                                  height: 70,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: timeSlots.keys.length,
                                    itemBuilder: (context, index) {
                                      DateTime date = timeSlots.keys.elementAt(index);
                                      String weekDay = DateFormat.E().format(date); // Get month name abbreviation
                                      return GestureDetector(
                                        onTap: () => _updateSelectedDate(date),
                                        child: Container(
                                          width: 60,
                                          margin: const EdgeInsets.symmetric(horizontal: 5),
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                          decoration: BoxDecoration(
                                              color: selectedDate == date ? mainColor : const Color(0xFFE3F5E5), borderRadius: BorderRadius.circular(10), border: Border.all(color: mainColor)),
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  weekDay,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: selectedDate == date ? Colors.white : Colors.black,
                                                    fontFamily: regular,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${date.day}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: selectedDate == date ? Colors.white : Colors.black,
                                                    fontFamily: regular,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 27.h),
                                Row(
                                  children: [
                                    Image.asset(
                                      clockTime,
                                      height: 16.h,
                                      width: 16.w,
                                      color: mainColor,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "Time Slots",
                                      style: TextStyle(
                                        color: mainColor,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12.sp,
                                        fontFamily: semiBold,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),
                                GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10.0,
                                    crossAxisSpacing: 10.0,
                                    childAspectRatio: 4,
                                  ),
                                  itemCount: timeSlots[selectedDate]?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    TimeSlotData timeSlot = timeSlots[selectedDate]![index];
                                    bool isSelected = selectedTimeSlots.contains(timeSlot);
                                    return GestureDetector(
                                      onTap: () => _toggleTimeSlot(timeSlot),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 9.h),
                                        decoration: BoxDecoration(
                                          image: isSelected
                                              ? null
                                              : const DecorationImage(
                                                  image: AssetImage(lineDotTime),
                                                  fit: BoxFit.fill,
                                                ),
                                          color: isSelected ? mainColor : whiteCl,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            timeSlot.title.toString(),
                                            style: TextStyle(
                                              color: isSelected ? whiteCl : const Color(0xFF807E7E),
                                              fontFamily: regular,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          }),
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
                        onPressed: () async {
                          if (selectedTimeSlot == 0) {
                            if (contextCtr.allCategoryListModel == null) {
                              errorToast("Select Category ");
                            } else if (contextCtr.subCategoryListModel == null) {
                              errorToast("Select SubCategory ");
                            } else if (contextCtr.selectedService.isEmpty) {
                              errorToast("Select Service ");
                            } else {
                              var result = await controller.createService(contextCtr.allCategoryListModel.value.toString(), contextCtr.subCategoryListModel.value.toString());
                              if (result.isNotEmpty && result[0]) {
                                setState(() {
                                  selectedTimeSlot = 1;
                                });
                                successToast(result[1].toString());
                              } else {
                                errorToast(result.isNotEmpty ? result[1] : "Something went wrong");
                              }
                            }
                          } else {
                            if (selectedTimeSlotsMap.isNotEmpty) {
                              selectedTimeSlotsMap.forEach((DateTime date, List<TimeSlotData> timeSlots) {
                                String weekDay = DateFormat.E().format(date);
                                for (int i = 0; i < timeSlots.length; i++) {
                                  controller.createTimeslots(weekDay.toLowerCase().toString(), timeSlots[i].id.toString());
                                }
                              });
                            }
                          }
                        },
                        text: 'Submit',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class CustomMultiSelectDropdown extends StatelessWidget {
  final List<ServiceListModel> items;
  final RxList<ServiceListModel> selectedItems;
  final ValueChanged<List<ServiceListModel>> onChanged;
  final AddServiceController controller;

  const CustomMultiSelectDropdown({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: InkWell(
        onTap: () => _showMultiSelectDialog(context),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColorCont),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Obx(() => Text(
                _buildSelectedItemsText(),
                style: selectedItems.isEmpty
                    ? const TextStyle(fontWeight: FontWeight.w400, color: Color.fromRGBO(166, 166, 166, 0.7), fontFamily: regular, fontSize: 14 , fontStyle: FontStyle.normal)
                    : const TextStyle(
                        fontFamily: regular,
                        color: blackCl,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
              )),
        ),
      ),
    );
  }

  String _buildSelectedItemsText() {
    if (selectedItems.isEmpty) {
      return "Select Services";
    } else {
      return selectedItems.map((item) => item.label.toString()).join(", ");
    }
  }

  void _showMultiSelectDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text(
                  "Select Services",
                  style: TextStyle(
                    fontFamily: regular,
                    color: blackCl,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                content: Container(
                  width: double.maxFinite,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: ListView(
                    shrinkWrap: true,
                    children: items.map((item) {
                      bool isSelected = selectedItems.contains(item);
                      return ListTile(
                        title: Text(item.label.toString()),
                        leading: isSelected ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              controller.selectedService.remove(item.value.toString());
                              controller.selectedServiceList.remove(item);
                              selectedItems.remove(item);
                            } else {
                              controller.selectedService.add(item.value.toString());
                              controller.selectedServiceList.add(item);
                              selectedItems.add(item);
                            }
                            onChanged(selectedItems.toList());
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text(
                      "Done",
                      style: TextStyle(
                        fontFamily: regular,
                        color: blackCl,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        });
  }
}
