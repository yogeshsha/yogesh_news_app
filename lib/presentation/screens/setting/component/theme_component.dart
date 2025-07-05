import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/presentation/screens/setting/component/toggle_setting_component.dart';

import '../../../widgets/simple_text.dart';
import 'drop_down_setting_component.dart';
import 'toggle_setting_component.dart';

class ThemeComponent extends StatelessWidget {
  final Function(bool) onChangeDarkMode;
  final bool darkModeValue;
  final List<DropdownMenuItem<String>> list;
  final bool fontSizeLoader;
  final String hint;
  final String? initialValue;
  final Function(String) onChange;

  const ThemeComponent(
      {super.key,
      required this.onChangeDarkMode,
      this.fontSizeLoader = false,
      required this.darkModeValue,
      required this.list,
      required this.hint,
      required this.onChange,
      required this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SimpleText(
            text: "Theme",
            size: 18,
            weight: FontWeight.w600,
            color: Theme.of(context).colorScheme.secondary,
          ),
          ToggleSettingComponent(
            onChange: onChangeDarkMode,
            toggleValue: darkModeValue,
            title: "Dark Mode",
            titleStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 14),
          ),
          const SizedBox(height: 10),
          DropDownSettingComponent(
              isLoading: fontSizeLoader,
              title: "Font Size",
              onChange: onChange,
              list: list,
              hint: hint,
              initialValue: initialValue)
        ],
      ),
    );
  }
}
