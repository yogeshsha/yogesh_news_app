import 'package:flutter/material.dart';
import 'package:newsapp/constants/app_constant.dart';
// import 'package:text_to_speech/text_to_speech.dart';
import '../../../utils/app_localization.dart';
import 'component/favorite.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  SessionHelper? sessionHelper;
  // TextToSpeech tts = TextToSpeech();

  @override
  void initState() {
    initSession();
    // tts.setRate(0.7);
    super.initState();
  }
  void initSession() async {
    sessionHelper = await SessionHelper.getInstance(context);
    setState(() {});
  }
  @override
  void dispose() {
    // tts.stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.translate("My Favorite"),
          style:
              TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: const Favorite()
        // child: Favorite(tts: tts,)
        // sessionHelper != null ? sessionHelper!.get(SessionHelper.USER_ID) != null ?
        //     favorite.isNotEmpty ?
        //     favorites()
                // :
        // Center(
        //   child:  Text(
        //     "No Favorite Found",
        //     style:
        //     TextStyle(color: Theme.of(context).textTheme.displayLarge!.color,fontSize: 25,fontWeight: FontWeight.bold),
        //   )
        // )
        //     : noFavoriteFound() : noFavoriteFound()
      ),
    );
  }
  // Widget favorites(){
  //   return  GridView.builder(
  //     shrinkWrap: true,
  //     padding: EdgeInsets.zero,
  //     physics: const BouncingScrollPhysics(),
  //     itemCount: favorite.length,
  //     gridDelegate:
  //     const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2, // Number of columns
  //         mainAxisSpacing: 12, // Spacing between rows
  //         crossAxisSpacing: 12, // Spacing between columns
  //         childAspectRatio: 80 / 100),
  //     itemBuilder: (BuildContext context, int index) {
  //       return Stack(
  //         children: [
  //           Positioned(
  //               top: 0,
  //               left: 0,
  //               right: 0,
  //               bottom: 0,
  //               child: fancyShimmerImageWidget(
  //                   favorite[index].posterImage,
  //                   radius: BorderRadius.circular(10))),
  //
  //           InkWell(
  //             onTap: () {
  //               Navigator.pushNamed(context, "/details",
  //                   arguments:
  //                   favorite[index].id.toString());
  //
  //             },
  //             child: Container(
  //               width: MediaQuery.of(context).size.width / 2,
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(10),
  //                   // Image border
  //                   boxShadow: const [
  //                     BoxShadow(
  //                       color: Colors.black38,
  //                       blurRadius: 0,
  //                     ),
  //                   ]),
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(
  //                     horizontal: 18, vertical: 12),
  //
  //                 // padding: const EdgeInsets.all(18.0),
  //                 child: Column(
  //                   crossAxisAlignment:
  //                   CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: [
  //                     const Spacer(),
  //                     text1(
  //                         favorite[index].newsCategory!
  //                             .name!,
  //                         context),
  //                     const SizedBox(
  //                       height: 6,
  //                     ),
  //                     text2(favorite[index].title!),
  //                     const SizedBox(
  //                       height: 6,
  //                     ),
  //                     text1(
  //                         dateChange(
  //                             favorite[index].createdAt!),
  //                         context),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //           sessionHelper == null
  //               ? const SizedBox()
  //               : sessionHelper!.get(SessionHelper.USER_ID) ==
  //               null
  //               ? const SizedBox()
  //               : Positioned(
  //             right: 0,
  //             top: 0,
  //             child: IconButton(
  //                 onPressed: () {
  //                   // setState(() {
  //                   //   favorite[index].isLiked =
  //                   //       !favorite[index].isLiked;
  //                   // });
  //                 },
  //                 icon: Icon(
  //                   // favorite[index].isLiked
  //                   //     ? Icons.favorite
  //                   //     :
  //                   Icons.favorite_border,
  //                   color: colorsConstants.heartColor,
  //                 )),
  //           ),
  //           Positioned(
  //               top : 0,
  //               right : 20,
  //               child: IconButton(
  //                 icon: const Icon(
  //                   Icons.volume_up_outlined,color: Colors.white,),
  //                 onPressed: (){
  //                   tts.speak(favorite[index].title!,);
  //                 },
  //               )
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

}
