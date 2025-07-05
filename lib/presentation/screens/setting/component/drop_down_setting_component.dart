import 'package:flutter/material.dart';
import 'package:newsapp/presentation/widgets/drop_down_widget.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';

class DropDownSettingComponent extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final EdgeInsets? padding;
  final List<DropdownMenuItem<String>> list;
  final bool isLoading;

  final String? initialValue;
  final String hint;
  final Function(String) onChange;

  const DropDownSettingComponent(
      {super.key,
      this.title,
      this.titleStyle,
        this.isLoading = false,
      required this.onChange,
      this.padding,
      required this.list,
      this.initialValue,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title != null)
            Expanded(child: SimpleText(text: title ?? "", style: titleStyle)),
          isLoading ?
              const CircularProgressIndicator()
              :
          DropDownWidget(
              radius: 10,
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                initialValue: initialValue,
                items: list,
                isExpanded: false,
                onChange: onChange,
                hint: hint,
                initialHint: hint)
        ],
      ),
    );
  }
}
