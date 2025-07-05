import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsapp/presentation/widgets/text_form_field.dart';
import '../../constants/app_constant.dart';
import '../../constants/colors_constants.dart';
import '../../constants/images_constants.dart';
import '../../utils/de_bouncer.dart';
import 'ink_well_custom.dart';

class SearchMicComponent extends StatefulWidget {
  final TextEditingController searchController;
  final bool showFilter;
  final Function? onTapShowFilter;
  final Function callApi;
  final double? leftPadding;
  final double? topPadding;
  final double? curve;
  final double? rightPadding;
  final Widget? searchComponent;

  const SearchMicComponent(
      {super.key,
        required this.searchController,
        this.showFilter = false,
        this.searchComponent ,
        this.onTapShowFilter,required this.callApi, this.leftPadding, this.rightPadding, this.topPadding, this.curve});

  @override
  State<SearchMicComponent> createState() => _SearchMicComponentState();
}

class _SearchMicComponentState extends State<SearchMicComponent> {
  final DeBouncer _deBouncer = DeBouncer(delay: AppConstant.deBouncerDuration);

  @override
  void initState() {
    widget.searchController.addListener(_onSearchChanged);
    super.initState();
  }

  // Debounce
  void _onSearchChanged() {
    _deBouncer.run(() {
      widget.callApi();
    });
  }
  @override
  void dispose() {
    widget.searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchComponent ??  Positioned(
      top:widget.topPadding ??  10,
      left:widget.leftPadding ??10,
      right:widget.rightPadding ?? 10,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          // color: ColorsConstants.white,
        ),
        child:TextFormFieldWidget(
          margin: EdgeInsets.zero,
          borderCurve:widget.curve ?? 20,
          controller: widget.searchController,
          validation: (value) => null,
          hint: "Search",
          inputFormatters: [AppConstant.denyAndOperator],
          prefix: Icon(
            Icons.search,
            color: ColorsConstants.textFieldColor,
            size: 25,
          ),
          suffix: widget.showFilter
              ? Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWellCustom(
              onTap: () {
                if (widget.onTapShowFilter != null) {
                  widget.onTapShowFilter!();
                }
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0, vertical: 13),
                  child: SvgPicture.asset(
                    ImagesConstants.filterIcon,
                    fit: BoxFit.fitHeight,
                    height: 5,
                    width: 5,
                  )),
            ),
          )
              : const SizedBox(),
        ),
      ),
    );
  }
}
