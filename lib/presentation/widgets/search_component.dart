import 'package:flutter/material.dart';
import 'package:newsapp/presentation/widgets/text_form_field.dart';

import '../../constants/app_constant.dart';
import '../../constants/colors_constants.dart';
import '../../utils/de_bouncer.dart';

class SearchComponent extends StatefulWidget {
  final TextEditingController searchController;
  final Widget? suffix;
  final Widget? prefix;
  final Function? onTapShowFilter;
  final Function callApi;
  final double? leftPadding;
  final double? topPadding;
  final double? curve;
  final double? rightPadding;
  final Widget? searchComponent;
  final bool? borderEnable;

  const SearchComponent(
      {super.key,
      required this.searchController,

      this.searchComponent ,
      this.onTapShowFilter,
        required this.callApi,
        this.leftPadding,
        this.rightPadding,
        this.topPadding,
        this.curve,
        this.suffix,
        this.borderEnable,
        this.prefix});

  @override
  State<SearchComponent> createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
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
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        // color: ColorsConstants.white,
      ),
      child:TextFormFieldWidget(
        borderEnable: widget.borderEnable??true,
        margin: EdgeInsets.zero,
        borderCurve:widget.curve ?? 25,
        controller: widget.searchController,
        validation: (value) => null,
        hint: "Search",
        inputFormatters: [AppConstant.denyAndOperator],
        prefix: widget.prefix ??Icon(
          Icons.search,
          color: ColorsConstants.textFieldColor,
          size: 25,
        ),
        suffix:widget.suffix,
      ),
    );
  }
}



