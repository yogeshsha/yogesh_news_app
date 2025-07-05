import 'package:flutter/material.dart';
import 'package:newsapp/presentation/widgets/fancy_shimmer_image.dart';
import 'package:newsapp/presentation/widgets/vertical_divider.dart';

Widget bannerWidget(BuildContext context,String image, String text,{Function? onTap}) {
  return InkWell(
    onTap: (){
      if(onTap != null){
        onTap();
      }
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.red,
      constraints: const BoxConstraints(minHeight: 75),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 100,
                    width: 100,
                    child: fancyShimmerImageWidget(image)
                ),
               verticalDivider(),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                  text,
                  style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18,overflow: TextOverflow.ellipsis,height: 1.5),
                  maxLines: 3,
                ),
                    ))
              ],
            ),
            // Positioned(
            //   top:5,
            //     right: 0,
            //     height: 29,
            //     child:  ElevatedButton(
            //       style:  ElevatedButton.styleFrom(
            //         side: const BorderSide(color: Colors.white,width: 1), backgroundColor: Colors.black12,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10.0),
            //         ),
            //       ),
            //       child: Text(
            //        check ? "view less" : "view more",
            //         style: const TextStyle(
            //             color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
            //       ),
            //       onPressed: () {
            //         if(onTap != null){
            //           onTap();
            //         }
            //       },
            //     ),
            // ),
            const Positioned(
              top:1,
              right: 0,
              // height: 20,
              child:
              Icon(Icons.keyboard_arrow_right_outlined,color: Colors.white,),
              // Icon(check ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_outlined,color: Colors.white,),
            ),
          ],
        ),
      ),
    ),
  );
}
