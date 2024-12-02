import 'package:Jo_Students/screens/end_drawer/lessons_end_drawer/selected_semester_controller.dart';
import 'package:Jo_Students/utils/ui/common_views.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';


class MyDropdownButton extends StatefulWidget {
  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  Color borderColorCountry = Colors.grey; // Initial border color
  final FocusNode _focusNodeCountry = FocusNode(); // FocusNode for interaction

  @override
  void initState() {
    super.initState();
    // Listener to detect focus and change the border color
    _focusNodeCountry.addListener(() {
      setState(() {
        borderColorCountry = _focusNodeCountry.hasFocus
            ? const Color(0xff7367f0) // Change to desired color on focus
            : Colors.grey; // Revert to default color
      });
    });
  }

  @override
  final SelectedCountryController controllerCountry =
  Get.put(SelectedCountryController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(19.0),
          child:
          Obx(() {
            return Center(
              child:
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  focusNode: _focusNodeCountry,
                  // Attach FocusNode to detect interaction
                  isExpanded: true,
                  hint: CommonViews().customText(
                    textContent: controllerCountry.selectedValue.value,
                    textColor: Theme
                        .of(context)
                        .textTheme
                        .displayLarge
                        ?.color,
                    fontSize: 14.sp,
                  ),
                  items: controllerCountry.getCountryList().map((item) {
                    final isSelected = item ==
                        controllerCountry.selectedValue.value;

                    return DropdownMenuItem<String>(
                      value: item,
                      child: Container(
                        width: double.infinity, // Ensure full horizontal width
                        height: 40, // Item height
                        color: isSelected ? Colors.blue.shade200 : Colors.transparent, // Color based on selection
                        alignment: Alignment.topRight,
                        child: CommonViews().customText(
                          textContent: item,
                          textAlign: TextAlign.right,
                          textColor: isSelected
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).textTheme.bodyLarge?.color,
                          fontSize: 14.sp,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }).toList(),
                  value: controllerCountry.selectedValue.value,
                  onChanged: (String? value) {
                    if (value != null) {
                      controllerCountry.selectValue(value);
                    }
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 5.h,
                    width: 100.w,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: borderColorCountry,
                        // Use the state variable for border color
                        width: 2,
                      ),
                      color: Theme
                          .of(context)
                          .appBarTheme
                          .backgroundColor,
                    ),
                  ),
                  iconStyleData: IconStyleData(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme
                          .of(context)
                          .textTheme
                          .displayLarge
                          ?.color,
                      size: 22,
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight:23.h,
                    width: 100.w-36,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                    ),

                    offset: const Offset(0, 1),
                  ),
                  selectedItemBuilder: (context) {
                    return controllerCountry.getCountryList().map((item) {
                      return CommonViews().customText(
                        textContent: item,
                        textColor:
                        Theme.of(context).textTheme.displayLarge!.color,
                        fontSize: 14.sp,
                      );
                    }).toList();
                  },
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
