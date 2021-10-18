import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:student_app/utils/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final TextStyle? errorStyle;
  final double? radius;
  final TextStyle? textStyle;
  final bool borderIsEnabled;
  final double? horizontalMargin;
  final bool defaultHorizontalMarginIsEnabled;
  final bool enabled;
  final String? initialValue;
  final String? hintTxt;
  final TextInputType? inputData;
  final bool isPassword;
  final String? Function(String?)? validationFunction;
  final dynamic Function(String?)? onChangedFunction;
  final Widget? suffix;
  final Widget? suffixIcon;
  final bool suffixIconIsImage;
  final String? suffixIconImagePath;
  final int? maxLength;
  final int? maxLines;
  final Widget? prefix;
  final Widget? prefixIcon;
  final bool prefixIconIsImage;
  final String? prefixIconImagePath;
  final String? labelTxt;
  final bool expands;
  final double? verticalPadding;
  final double? horizontalPadding;
  final TextEditingController? controller;
  final Color? unfocusColor;
  final Color? hintColor;
  final Color? focusColor;
  final Color? filledColor;
  final bool filled;
  final List<MaskTextInputFormatter>? inputFormatters;
  final AutovalidateMode autovalidateMode;
  final TextAlignVertical? textAlignVertical;
  final TextAlign? textAlign;

  const CustomTextFormField(
      {Key? key,
      this.hintTxt,
      this.textStyle,
      this.textAlignVertical,
      this.textAlign,
      this.errorStyle,
      this.borderIsEnabled = true,
      this.radius,
      this.horizontalMargin,
      this.defaultHorizontalMarginIsEnabled = true,
      this.inputData,
      this.isPassword = false,
      this.validationFunction,
      this.onChangedFunction,
      this.initialValue,
      this.suffixIcon,
      this.maxLength,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.prefixIconIsImage = false,
      this.suffixIconIsImage = false,
      this.prefixIconImagePath,
      this.suffixIconImagePath,
      this.enabled = true,
      this.maxLines,
      this.expands = false,
      this.labelTxt,
      this.prefix,
      this.verticalPadding,
      this.horizontalPadding,
      this.unfocusColor,
      this.hintColor,
      this.focusColor,
      this.suffix,
      this.filled = true,
      this.filledColor,
      this.prefixIcon,
      this.controller,
      this.inputFormatters})
      : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obsecureText = true;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  Widget _buildTextFormField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: widget.inputFormatters,
      expands: widget.expands,
      controller: widget.controller,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      focusNode: _focusNode,
      maxLength: widget.maxLength,
      initialValue: widget.initialValue,
      style: const TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        filled: widget.filled ? true : false,
        fillColor: widget.filledColor ?? Colors.white,
        border: widget.borderIsEnabled
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    (widget.radius == null ? 12 : widget.radius!)),
                borderSide: BorderSide(
                  color: (_focusNode.hasFocus
                      ? widget.focusColor ?? mainAppColor
                      : widget.unfocusColor ?? hintColor),
                )),
        enabledBorder: !widget.borderIsEnabled
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    (widget.radius ?? 10.0)),
                borderSide: BorderSide(
                  color: (_focusNode.hasFocus
                      ? widget.focusColor ?? mainAppColor
                      : widget.unfocusColor ?? hintColor),
                )),
        contentPadding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding == null
              ? 12.0
              : widget.horizontalPadding!,
          vertical:
              widget.verticalPadding == null ? 12.0 : widget.verticalPadding!,
        ),
        suffix: widget.isPassword
            ? InkWell(
                onTap: () {
                  setState(() {
                    _obsecureText = !_obsecureText;
                  });
                },
                child: Icon(
                  _obsecureText ? Icons.remove_red_eye : Icons.visibility_off,
                  color: _focusNode.hasFocus ? mainAppColor : hintColor,
                  size: 20,
                ),
              )
            : const SizedBox(
                height: 20,
              ),
        suffixIcon: !widget.suffixIconIsImage
            ? widget.suffixIcon
            : _focusNode.hasFocus
                ? Image.asset(
                    (widget.suffixIconImagePath)!,
                    color: mainAppColor,
                    height: 25,
                    width: 25,
                  )
                : Image.asset(
                    (widget.suffixIconImagePath!),
                    color: Colors.grey,
                    height: 25,
                    width: 25,
                  ),
        prefix: widget.prefix,
        prefixIcon: !widget.prefixIconIsImage
            ? widget.prefixIcon
            : _focusNode.hasFocus
                ? Image.asset(
                    (widget.prefixIconImagePath!),
                    color: mainAppColor,
                    height: 25,
                    width: 25,
                  )
                : Image.asset(
                    (widget.prefixIconImagePath!),
                    color: hintColor,
                    height: 25,
                    width: 25,
                  ),
        hintText: widget.hintTxt,
        labelText: widget.labelTxt,
        labelStyle: TextStyle(
            color: const Color(0xff0D0D0F).withOpacity(0.5),
            fontSize: 12,
            fontWeight: FontWeight.bold),
        errorStyle: widget.errorStyle ?? const TextStyle(fontSize: 12.0),
        hintStyle: TextStyle(
            color: _focusNode.hasFocus
                ? mainAppColor
                : widget.hintColor ?? const Color(0xffDCDCDC),
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
      keyboardType: widget.inputData,
      obscureText: widget.isPassword ? _obsecureText : false,
      validator: widget.validationFunction,
      onChanged: widget.onChangedFunction,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
            horizontal: widget.horizontalMargin != null
                ? widget.horizontalMargin!
                : widget.defaultHorizontalMarginIsEnabled
                    ? 20.0
                    : 0),
        child: _buildTextFormField());
  }
}
