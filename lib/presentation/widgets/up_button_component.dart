import 'package:flutter/material.dart';
import '../../constants/colors_constants.dart';
import '../../utils/app.dart';
import 'ink_well_custom.dart';

class UpButtonComponent extends StatefulWidget {
  final bool showButton;
  final ScrollController scrollController;
  final double bottom;
  final double right;
  final bool isArrowUp;
  final Function(bool) onChange;

  const UpButtonComponent(
      {super.key,
      required this.showButton,
      required this.scrollController,
      this.bottom = 5,
      this.right = 10,
      this.isArrowUp = true,
      required this.onChange});

  @override
  State<UpButtonComponent> createState() => _UpButtonComponentState();
}

class _UpButtonComponentState extends State<UpButtonComponent> {
  bool checkInternet = true;

  @override
  Widget build(BuildContext context) {
    AppHelper.showUpButton(
        scrollController: widget.scrollController,
        showButton: widget.showButton,
        onChange: (bool value) {
          widget.onChange(value);
        },
        setState: () {
          if (checkInternet) {
            setState(() {});
          }
        });
    return Positioned(
        right: widget.right,
        bottom: widget.bottom,
        child: widget.showButton
            ? Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: ColorsConstants.titleColor, shape: BoxShape.circle),
                child: InkWellCustom(
                  onTap: () {
                    widget.scrollController
                        .animateTo(
                          widget.scrollController.position.minScrollExtent,
                          duration: const Duration(microseconds: 1),
                          curve: Curves.linear,
                        )
                        .then((value) => widget.onChange(false));
                  },
                  child: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Icon(
                        widget.isArrowUp
                            ? Icons.keyboard_arrow_up_sharp
                            : Icons.keyboard_arrow_down_sharp,
                        color: ColorsConstants.white),
                  ),
                ),
              )
            : const SizedBox());
  }
}
