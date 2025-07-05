import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';

import 'arrow_text_component.dart';

class NotificationComponent extends StatelessWidget {
  final Function onTapAppNotification;

  const NotificationComponent(
      {super.key,
      required this.onTapAppNotification});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SimpleText(
              text: "Notification",
              size: 18,
              weight: FontWeight.w600,
              color: Theme.of(context).colorScheme.secondary),
          const SizedBox(height: 10),
          ArrowTextComponent(
              title: "App Notification",
              titleStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color:Theme.of(context).colorScheme.onSecondary,
                  fontSize: 14),
              onTap: onTapAppNotification)
        ],
      ),
    );
  }
}
