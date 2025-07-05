import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';

import 'arrow_text_component.dart';

class BookmarkComponent extends StatelessWidget {
  final Function onTapBookmark;
  final Function onTapAccount;

  const BookmarkComponent(
      {super.key,
      required this.onTapBookmark,required this.onTapAccount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SimpleText(
              text: "Account",
              size: 18,
              weight: FontWeight.w600,
              color: Theme.of(context).colorScheme.secondary),
          const SizedBox(height: 10),
          ArrowTextComponent(
              title: "Show Account",
              titleStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color:Theme.of(context).colorScheme.onSecondary,
                  fontSize: 14),
              onTap: onTapAccount),
          const SizedBox(height: 10),
          ArrowTextComponent(
              title: "Show All Bookmark",
              titleStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color:Theme.of(context).colorScheme.onSecondary,
                  fontSize: 14),
              onTap: onTapBookmark)
        ],
      ),
    );
  }
}
