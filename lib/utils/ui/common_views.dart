import 'package:flutter/material.dart';
import 'package:jo_students/configuration/app_colors.dart';
import 'package:sizer/sizer.dart';

class CommonViews {
  static final CommonViews _shared = CommonViews._private();

  factory CommonViews() => _shared;

  CommonViews._private();

  Widget customText(
      {required String textContent,
      Color? textColor,
      double? fontSize,
      bool? withFontFamily = true,
      int? maxLines,
      TextOverflow? overflow,
      TextAlign? textAlign,
      FontWeight? fontWeight}) {
    return Text(
      textContent,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: fontSize,
          fontFamily: (withFontFamily == true) ? 'GE Dinar One' : null,
          fontWeight: fontWeight),
    );
  }

  Widget customClickableText(
      {required String textContent,
      Color? textColor,
      required VoidCallback onTap,
      required double fontSize,
      bool? withFontFamily = true,
      TextAlign? textAlign,
      FontWeight? fontWeight}) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        onTap();
      },
      child: Text(
        textContent,
        textAlign: textAlign,
        style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: fontSize,
            fontFamily: (withFontFamily == true) ? 'GE Dinar One' : null,
            fontWeight: fontWeight),
      ),
    );
  }

  Widget createTextFormField(
      {required TextEditingController controller,
      required FocusNode focusNode,
      String? label,
      TextAlign? textAlign,
      required TextInputType keyboardType,
      TextInputAction? inputAction,
      final double? radius,
      ValueChanged<String>? onSubmitted,
      String? prefixText,
      String? hint,
        bool errorBorder=true,
      double? height,
      Widget? suffixIcon,
      int? maxLines,
      Icon? prefixIcon,
      Color? borderColor,
      Color? fillColor,
      String? errorText,
      bool? readOnly,
      FormFieldValidator<String>? validator,
      Color? textColor,
      Color? errorBorderColor,
      double? errorHeight,
      bool isObscure = false,
      }) {
    return SizedBox(
      height: height ?? 5.h,
      child: TextFormField(
        textAlign: textAlign ?? TextAlign.right,
        readOnly: readOnly ?? false,
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        maxLines: maxLines ?? 1,
        textInputAction: inputAction ?? TextInputAction.next,
        obscureText: isObscure,
        autovalidateMode: AutovalidateMode.disabled,
        validator: validator,
        onFieldSubmitted: onSubmitted,
        style: TextStyle(
          color: textColor ??Colors.black,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          alignLabelWithHint: true,
          errorText: errorText,
          label: Text(label ?? ""),
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
          errorStyle: TextStyle(height: errorHeight ?? 0.01),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: fillColor ?? AppColors.primaryColorLight,
          prefix: Text(prefixText ?? ''),
          suffixIcon: suffixIcon,
          enabledBorder: outlineInputBorder(radius, borderColor),
          focusedBorder: outlineInputBorder(radius, borderColor),
          errorBorder:errorBorder? outlineInputBorder(radius, errorBorderColor?? Colors.red):OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 15),
              borderSide: BorderSide.none),
          focusedErrorBorder: outlineInputBorder(radius, borderColor),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 15),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder(double? radius, Color? borderColor) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius ?? 15),
        borderSide: BorderSide(color: borderColor ?? Colors.transparent));
  }

  Widget customClickableContainer({
    required Widget child,
    double? width,
    double? height,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Color? colorBorder,
    final double? radius,
    Color? color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          FocusManager.instance.primaryFocus?.unfocus();
          onTap.call();
        }
      },
      child: Container(
        width: width ?? 40.w,
        height: height ?? 4.h,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 20)),
          color: color ?? const Color.fromRGBO(244, 184, 38, 1),
          border: Border.all(
            width: 1,
            color: colorBorder ?? const Color.fromRGBO(244, 184, 38, 1),
          ),
        ),
        child: child,
      ),
    );
  }

  ElevatedButton customButton(
      {required Widget child,
      required Color color,
      required double border,
      required VoidCallback onTap}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(border), // Border radius
          ),
        ),
        onPressed: onTap,
        child: child);
  }
}
