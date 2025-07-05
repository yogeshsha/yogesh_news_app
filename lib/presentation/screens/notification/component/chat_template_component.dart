import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/constants/colors_constants.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';
import 'package:newsapp/utils/image_builder.dart';

import '../../../../data/notification_data/domain/notification_model/all_notification_model.dart';
import '../../../widgets/text_common.dart';
import 'get_dynamic_button_component.dart';

class ChatTemplateComponent extends StatelessWidget {
  final String image;
  final String title;
  final String time;
  final String message;
  final List<ActionsModel> actions;

  const ChatTemplateComponent(
      {super.key,
      required this.image,
      required this.title,
      required this.message,
      required this.time,
      required this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Theme.of(context).colorScheme.surface),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ImageBuilder.imageBuilder4(image, height: 43, width: 43),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SimpleText(
                  text: title,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w400),
                ),
                TextAll(
                    text: time,
                    weight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                    max: 12,
                    textDynamic: true),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Theme.of(context).colorScheme.onTertiaryContainer),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: const EdgeInsets.only(top: 5),
                  child: SimpleText(
                    text: message,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                if (actions.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runAlignment: WrapAlignment.start,
                      spacing: 5,
                      runSpacing: 5,
                      children: actions
                          .map((e) => GetDynamicButtonComponent(model: e))
                          .toList(),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
