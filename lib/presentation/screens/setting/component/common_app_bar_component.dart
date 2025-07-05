import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/presentation/widgets/arrow_back_ios.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';

import '../../../widgets/share_component.dart';
import '../../home/component/bookmark_component.dart';

class CommonAppBarComponent extends StatelessWidget {
  final String title;
  final bool arrowBackAllow;
  final Function? onTapBackArrow;
  final Function(bool value)? onTapBookmark;
  final EdgeInsetsGeometry? padding;
  final bool? isLiked;
  final bool? showBookMark;
  final bool? showShare;
  final Function? onTapShare;

  const CommonAppBarComponent(
      {super.key,
      required this.title,
      this.arrowBackAllow = true,
      this.onTapBackArrow,
      this.showShare,
      this.padding,
      this.onTapBookmark,
      this.isLiked,
      this.showBookMark, this.onTapShare});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // if (arrowBackAllow)
          ArrowBackButton(onTap: onTapBackArrow),
          Expanded(
            child: SimpleText(
              text: title,
              alignment: TextAlign.center,
              style: GoogleFonts.crimsonText(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
          const SizedBox(width: 40),
          if (showShare ?? false)
            ShareComponent(
                onTapShare:(){
                  if(onTapShare != null){
                    onTapShare!();
                  }
                }
            ),
          if (showBookMark ?? false)
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: BookMarkComponent2(
                  curve: 26,
                  onTapIsBookMark: () {
                    if (onTapBookmark != null) {
                      onTapBookmark!(!(isLiked ?? true));
                    }
                  },
                  isBookMarked: isLiked ?? false),
            )
          // InkWellCustom(
          //   onTap: (){
          //     if(onTapBookmark!= null){
          //       onTapBookmark!(!(isLiked??true));
          //     }
          //   },
          //   child: Container(
          //     padding: const EdgeInsets.all(5),
          //       decoration: BoxDecoration(
          //           shape: BoxShape.circle,color: ColorsConstants.arrowBackColor
          //       ),
          //       child:isLiked??true
          //           ?Icon(Icons.bookmark_outlined,size: 20,color:ColorsConstants.textGrayColor)
          //           :Icon(Icons.bookmark_border,size: 20,color:ColorsConstants.textGrayColor ,)
          //   ),
          // ),
        ],
      ),
    );
  }
}
