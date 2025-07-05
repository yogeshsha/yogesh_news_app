import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../constants/colors_constants.dart';
import '../../utils/dark_theme_provider.dart';

Widget switchWidget(BuildContext context) {
  final themeChange = Provider.of<DarkThemeProvider>(context);
  bool check = themeChange.darkTheme;
  return FlutterSwitch(
    width: 52,
    height: 35,
    // valueFontSize: 25.0,
    // toggleSize: 35.0,
    value: check,
    // borderRadius: 15.0,
    activeIcon: const Icon(
      Icons.dark_mode_outlined,
      color: Colors.black,
    ),
    inactiveIcon: const Icon(
      Icons.light_mode_outlined,
      color: Colors.white,
    ),
    inactiveColor: Colors.grey,
    activeColor: Colors.grey,
    activeToggleColor: Colors.white,
    inactiveToggleColor: Colors.black,
    // padding: 8.0,
    // showOnOff: true,
    onToggle: (val) {
      themeChange.darkTheme = val;
    },
  );
}
// Widget switchWidget(BuildContext context) {
//   final themeChange = Provider.of<DarkThemeProvider>(context);
//   bool check = themeChange.darkTheme;
//   return AnimatedToggleSwitch<bool>.dual(
//     current: check,
//     first: false,
//     second: true,
//     // dif: 0,
//     borderColor: Colors.transparent,
//     innerColor: check ? Colors.black : Colors.white,
//     // boxShadow: const [
//     //   BoxShadow(
//     //     color: Colors.black26,
//     //     spreadRadius: 1,
//     //     blurRadius: 2,
//     //     offset: Offset(0, 1.5),
//     //   ),
//     // ],
//     onChanged: (b) {
//       themeChange.darkTheme = b;
//     },
//     colorBuilder: (b) => b ? Colors.white : Colors.black,
//     iconBuilder: (value) => value
//         ? const Icon(
//             Icons.dark_mode_outlined,
//             color: Colors.black,
//           )
//         : const Icon(
//             Icons.light_mode_outlined,
//             color: Colors.white,
//           ),
//     //
//     // textBuilder: (value) => value
//     //     ? const Center(child: Text('Light',style: TextStyle(color: Colors.white),))
//     //     : const Center(child: Text('Dark')),
//   );
// }

class SwitchComponent extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;

  const SwitchComponent(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 30,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Switch(
          splashRadius: 0,
          value: value,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          trackOutlineWidth: MaterialStateProperty.resolveWith<double?>(
              (Set<MaterialState> states) {
            return 0;
          }),
          onChanged: (value) => onChanged(value),
          activeColor: ColorsConstants.white,
          activeTrackColor: ColorsConstants.appColor,
          inactiveThumbColor: ColorsConstants.white,
          inactiveTrackColor: ColorsConstants.textGrayColor,
        ),
      ),
    );
  }
}
