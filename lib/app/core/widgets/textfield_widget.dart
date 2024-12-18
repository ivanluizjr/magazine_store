import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magazine_store/app/core/themes/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final int maxLength;
  final int? maxLines;
  final int? minLines;
  final TextEditingController? controller;
  final String? initialValue;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final bool filled;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final bool obscureText;
  final Widget? prefix;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final Widget? suffix;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final InputBorder? border;
  final InputBorder? errorBorder;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool isCollapsed;
  final TextStyle? style;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final List<TextInputFormatter>? inputFormatters;
  final Color? colorStyle;
  final Color? colorHintStyle;

  const TextFieldWidget({
    this.controller,
    this.initialValue,
    this.enabled = true,
    this.contentPadding,
    this.filled = false,
    this.fillColor,
    this.focusNode,
    this.textInputType,
    this.prefix,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.suffix,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.obscureText = false,
    this.border = InputBorder.none,
    this.errorBorder = InputBorder.none,
    this.enabledBorder = InputBorder.none,
    this.focusedBorder = InputBorder.none,
    this.focusedErrorBorder = InputBorder.none,
    this.disabledBorder = InputBorder.none,
    this.isCollapsed = false,
    this.style,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.labelStyle,
    this.floatingLabelStyle,
    this.floatingLabelBehavior,
    this.maxLines,
    this.minLines,
    this.colorHintStyle,
    this.colorStyle,
    super.key,
    this.maxLength = 255,
  });

  factory TextFieldWidget.search({
    TextEditingController? controller,
    TextInputType textInputType = TextInputType.text,
    bool enabled = true,
    Color? colorBorder,
    double? widthBorder,
    Color? colorStyle,
    Color? colorHintStyle,
    TextStyle? style,
    String? hintText,
    TextStyle? hintStyle,
    Color? fillColor,
    bool? filled = false,
    EdgeInsetsGeometry? contentPadding,
    InputBorder? border,
    Function(String)? onChanged,
  }) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: colorBorder ?? Colors.grey,
        width: widthBorder ?? 0.0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.circular(5.0),
    );

    return TextFieldWidget(
      controller: controller,
      enabled: enabled,
      textInputType: textInputType,
      filled: true,
      fillColor: fillColor,
      onChanged: onChanged,
      contentPadding: contentPadding,
      prefixIcon: const Padding(
        padding: EdgeInsets.only(
          right: 20.0,
          left: 19.50,
        ),
        child: Icon(
          Icons.search,
          size: 24.0,
          color: AppColors.greyDark,
        ),
      ),
      prefixIconConstraints: const BoxConstraints(
        maxHeight: 25.0,
        maxWidth: 60.0,
      ),
      border: border,
      enabledBorder: border,
      focusedBorder: border,
      style: style ??
          GoogleFonts.poppins(
            color: colorStyle ?? Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
      hintText: hintText ?? 'Search Anything',
      hintStyle: hintStyle ??
          GoogleFonts.poppins(
            color: colorHintStyle ?? AppColors.greyDark.withOpacity(0.72),
            fontSize: 16.0,
            fontWeight: FontWeight.w200,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      focusNode: focusNode,
      initialValue: initialValue,
      controller: controller,
      style: style,
      obscureText: obscureText,
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      validator: validator,
      maxLines: maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        counterText: '',
        fillColor: fillColor,
        filled: filled,
        isDense: true,
        isCollapsed: isCollapsed,
        contentPadding: contentPadding,
        enabled: enabled,
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        prefix: prefix,
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints,
        suffix: suffix,
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints,
        floatingLabelStyle: floatingLabelStyle,
        floatingLabelBehavior: floatingLabelBehavior,
        border: border,
        errorBorder: errorBorder,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        focusedErrorBorder: focusedErrorBorder,
        disabledBorder: disabledBorder,
      ),
      onChanged: onChanged,
    );
  }
}
