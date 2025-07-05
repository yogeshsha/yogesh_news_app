import 'package:flutter/material.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';

import '../../../widgets/switch_widget.dart';

class ToggleSettingComponent extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final EdgeInsets? padding;
  final bool toggleValue;
  final Function(bool) onChange;

  const ToggleSettingComponent(
      {super.key,
      this.title,
      this.subTitle,
      this.titleStyle,
      this.subTitleStyle,
      required this.toggleValue,
      required this.onChange,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (title != null)
                SimpleText(text: title ?? "", style: titleStyle),
              if (subTitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SimpleText(text: subTitle ?? "", style: subTitleStyle),
                ),
            ],
          )),
          SwitchComponent(value: toggleValue, onChanged: onChange)
        ],
      ),
    );
  }
}
