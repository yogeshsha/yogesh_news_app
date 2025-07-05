import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/presentation/widgets/text_and_info_component.dart';
import 'package:newsapp/presentation/widgets/text_common.dart';
import '../../constants/colors_constants.dart';
import 'ink_well_custom.dart';

class ShowTextEditorText extends StatefulWidget {
  final String htmlContent;
  final String hint;
  final bool compulsory;
  final bool isBlack;
  final Function(String) updateHtmlContent;
  final Color color;
  final bool isEditable ;

  const ShowTextEditorText({
    super.key,
    required this.htmlContent,
    required this.hint,
    this.compulsory = false,
    this.isBlack = true,
    required this.updateHtmlContent,
    required this.color, required this.isEditable,
  });

  @override
  State<ShowTextEditorText> createState() => _ShowTextEditorTextState();
}

class _ShowTextEditorTextState extends State<ShowTextEditorText> {
  bool showFullText = true;
  int checkLength = 50;

  @override
  void initState() {
    setDetails();
    super.initState();
  }

 void setDetails(){
    showFullText = widget.htmlContent.length < checkLength;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    bool showButton = widget.htmlContent.length > checkLength;
    return Column(
      children: [
        TextAndInfoComponent(
            padding: EdgeInsets.zero,
            title: widget.hint,
            fontWeight: widget.isBlack ? FontWeight.w500 : FontWeight.w400,
            color: widget.isBlack ? ColorsConstants.black : null,
            isCompulsory: widget.compulsory),
        const SizedBox(height: 5),
        InkWellCustom(
          onTap: () {
            if(widget.isEditable){
              Navigator.pushNamed(context, "/textEditorComponent", arguments: {
                'title': widget.hint,
                'value': widget.htmlContent,
                'onChange': (String value) {
                  widget.updateHtmlContent(value);
                  if (value.length < checkLength) {
                    showFullText = true;
                    setState(() {});
                  }
                }
              });
            }

          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: widget.color)),
            padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15
                // widget.htmlContent.trim().isNotEmpty ? 5 : 15
            ),
            alignment: Alignment.centerLeft,
            child: widget.htmlContent.trim().isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Html(

                        shrinkWrap: true,
                        data: showFullText
                            ? widget.htmlContent
                            : '${widget.htmlContent.substring(0, checkLength)}...',
                        style: {
                          'body': Style(
                              fontSize: FontSize.medium,
                              // lineHeight: LineHeight.number(0.8),
                              margin: Margins.zero,
                              padding: HtmlPaddings.zero,
                              textAlign: TextAlign.start,
                              alignment: Alignment.centerLeft),
                        },
                      ),
                      if (showButton)
                        InkWellCustom(
                            onTap: () =>
                                setState(() => showFullText = !showFullText),
                            child: Text(
                              showFullText ? 'Show Less' : 'Show More',
                              style: GoogleFonts.poppins(
                                  color: ColorsConstants.appColor),
                            ))
                    ],
                  )
                : TextAll(
                    textDynamic: true,
                    text:
                        "Enter ${widget.hint}",
                    weight: FontWeight.w400,
                    color: ColorsConstants.skipColor,
                    max: 14),
          ),
        ),
      ],
    );
  }
}
