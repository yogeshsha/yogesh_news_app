import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/colors_constants.dart';
import '../../utils/app.dart';

class TextFormFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final Function(String) validation;
  final bool hide;
  final int? maxLength;
  final int? errorMaxLine;
  final TextInputType type;
  final Widget? suffix;
  final int maxLines;
  final bool readOnlyCheck;
  final bool hintTextColorBlack;
  final Widget? prefix;
  final String? hint;
  final Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry contentPadding;
  final TextAlign textAlign;
  final bool borderEnable;
  final bool compulsory;
  final bool textDynamic;
  final bool autoFocus;
  final bool showWordLength;
  final EdgeInsets margin;
  final double prefixIconWidth;
  final bool checkChangeLabelColor;
  final FontWeight textWeight;
  final double textSize;
  final double borderCurve;
  final TextCapitalization textCapitalization;

  const TextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.validation,
      this.label,
      this.hide = false,
      this.borderCurve = 25,
      this.hintTextColorBlack = false,
      this.autoFocus = false,
      this.type = TextInputType.text,
      this.suffix,
      this.textCapitalization = TextCapitalization.sentences,
      this.maxLines = 1,
      this.readOnlyCheck = false,
      this.onChange,
      this.maxLength = 200,
      this.inputFormatters,
      this.prefix,
      this.hint,
      this.textDynamic = false,
      this.compulsory = false,
      this.contentPadding =const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      this.margin = const EdgeInsets.symmetric(vertical: 10),
      this.textAlign = TextAlign.start,
      this.borderEnable = true,
      this.showWordLength = false,
      this.prefixIconWidth = 60,
      this.checkChangeLabelColor = false,
      this.errorMaxLine,
      this.textWeight = FontWeight.w400,
      this.textSize = 13});

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  final _observer = MyObserver();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(_observer);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    WidgetsBinding.instance.removeObserver(_observer);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.margin,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26), color: Colors.transparent),
      child: TextFormField(
        scrollPadding: const EdgeInsets.only(bottom: 150),
        focusNode: _focusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: widget.maxLength,
        autofocus: widget.autoFocus,
        textCapitalization: widget.textCapitalization,
        controller: widget.controller,
        textAlign: widget.textAlign,
        cursorOpacityAnimates: true,
        cursorColor: ColorsConstants.appColor,
        textAlignVertical: TextAlignVertical.center,
        obscureText: widget.hide,
        maxLines: widget.maxLines,
        readOnly: widget.readOnlyCheck,
        onChanged: widget.onChange,
        inputFormatters: widget.inputFormatters,
        scrollPhysics: const BouncingScrollPhysics(),
        keyboardType: widget.type,
        validator: (value) => widget.validation(value!),
        decoration: InputDecoration(
            errorMaxLines: widget.errorMaxLine,
            hintText: widget.hint != null
                    ?"${AppHelper.getDynamicString(context,widget.hint ?? "")}${widget.compulsory ? "*" : ""}"
                : widget.hint,
            counterText: widget.showWordLength ? null : "",
            hintMaxLines: 1,
            labelText: widget.label != null
                ? "${AppHelper.getDynamicString(context,widget.label ?? "")}${widget.compulsory ? "*" : ""}"
                : null,
            prefixIcon: widget.prefix,

            prefixIconConstraints: BoxConstraints(
              minWidth: widget.prefixIconWidth,
            ),
            alignLabelWithHint: true,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            labelStyle: GoogleFonts.poppins(
                fontWeight: widget.checkChangeLabelColor
                    ? FontWeight.w500
                    : FontWeight.w400,
                fontSize: widget.checkChangeLabelColor ? 16 : 14,
                color: widget.checkChangeLabelColor
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onTertiaryContainer.withOpacity(0.8)),
            hintStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: widget.hintTextColorBlack
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onTertiaryContainer.withOpacity(0.8)),
            suffixIcon: widget.suffix,
            contentPadding: widget.contentPadding,
            fillColor: Theme.of(context).colorScheme.onSecondaryContainer,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderCurve),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: widget.borderEnable
                    ? BorderSide(
                        width: 1,
                        color: Theme.of(context).colorScheme.surface
                      )
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(widget.borderCurve)),
            focusedBorder: OutlineInputBorder(
              borderSide: widget.borderEnable
                  ? BorderSide(color: Theme.of(context).colorScheme.surface)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(widget.borderCurve),
            )),
        style: GoogleFonts.poppins(
          color: Theme.of(context).colorScheme.onTertiaryContainer.withOpacity(0.8),
          fontWeight: widget.textWeight,
          fontSize: widget.textSize,
        ),
      ),
    );
  }
}

class MyObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    AppHelper.hideKeyboard();
  }
}
