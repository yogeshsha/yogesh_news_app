import 'package:flutter/material.dart';
import 'package:newsapp/presentation/widgets/text_common.dart';
import '../../constants/colors_constants.dart';
import 'ink_well_custom.dart';

class SquareTickBoxComponent extends StatelessWidget {
  final bool initialValue;
  final String text;
  final double? textSize;
  final Color? textColor;
  final Function(bool) onChange;

  const SquareTickBoxComponent(
      {super.key,
      required this.initialValue,
      required this.onChange,
      required this.text,
      this.textColor,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    return InkWellCustom(
      onTap: () {
        onChange(!initialValue);
      },
      child: Row(
        children: [
          Container(
            // height: 30,
            // width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: initialValue
                  ? ColorsConstants.black.withOpacity(.2)
                  : Theme.of(context).primaryColor,
            ),
            padding: const EdgeInsets.all(6),
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: initialValue ? ColorsConstants.appColor : Theme.of(context).primaryColor,
                  border: Border.all(color: ColorsConstants.appColor)),
              child: initialValue
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 12,
                    )
                  : const SizedBox(),
            ),
          ),
          const SizedBox(width: 5),
          InkWellCustom(
            onTap: () {},
            child: TextAll(
                text: text,
                weight: FontWeight.w400,
                color: textColor ?? Theme.of(context).colorScheme.primary,
                max: textSize ?? 14),
          )
        ],
      ),
    );
  }
}
