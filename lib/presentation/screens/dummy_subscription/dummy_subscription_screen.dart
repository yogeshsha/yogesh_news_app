// import 'package:flutter/material.dart';
// import 'package:newsapp/presentation/screens/subscription/dummy_subscription_bloc_widget.dart';
//
// import '../../../constants/app_constant.dart';
// import '../../../utils/app.dart';
// import '../../../utils/app_localization.dart';
// import '../../widgets/arrow_back_ios.dart';
// import '../../widgets/drawer_widgets.dart';
//
// class SubscriptionScreen extends StatefulWidget {
//   const SubscriptionScreen({super.key});
//
//   @override
//   State<SubscriptionScreen> createState() => _SubscriptionScreenState();
// }
//
//
//
// class _SubscriptionScreenState extends State<SubscriptionScreen> {
//   SessionHelper? sessionHelper;
//
//   List list = [
//     {
//       "title" : "Basic",
//       "amount" : 100,
//       "date" : "2021-11-11"
//     } ,
//     {
//       "title" : "Basic",
//       "amount" : 100,
//       "date" : "2021-11-11"
//     } ,
//     {
//       "title" : "Basic",
//       "amount" : 100,
//       "date" : "2021-11-11"
//     } ,
//     {
//       "title" : "Basic",
//       "amount" : 100,
//       "date" : "2021-11-11"
//     } ,
//     {
//       "title" : "Basic",
//       "amount" : 100,
//       "date" : "2021-11-11"
//     } ,
//     {
//       "title" : "Basic",
//       "amount" : 100,
//       "date" : "2021-11-11"
//     } ,
//     {
//       "title" : "Basic",
//       "amount" : 100,
//       "date" : "2021-11-11"
//     } ,
//     {
//       "title" : "Basic",
//       "amount" : 100,
//       "date" : "2021-11-11"
//     } ,
//     {
//       "title" : "Basic",
//       "amount" : 100,
//       "date" : "2021-11-11"
//     } ,
//     {
//       "title" : "Basic",
//       "amount" : 100,
//       "date" : "2021-11-11"
//     } ,
//   ];
//   void initSession() async {
//     sessionHelper = await SessionHelper.getInstance(context);
//     sessionHelper!.put(SessionHelper.isShowAds, "true");
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     initSession();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       appBar: AppBar(
//         elevation: 0,
//         actions: [
//           SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: arrowBack(context),
//                 ),
//                 Text(
//                   AppLocalizations.of(context)!.translate("Subscription Page"),
//
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: Theme.of(context).textTheme.displayLarge!.color),
//                 ),
//                 const SizedBox()
//                 // logo(animationController)
//               ],
//             ),
//           )
//         ],
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).textTheme.bodyLarge!.color,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 margin: const EdgeInsets.all(10),
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       AppLocalizations.of(context)!.translate("Current Plan"),
//                       style: TextStyle(
//                           color:
//                           Theme.of(context).textTheme.displayLarge!.color,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 5,),
//                     Text(
//                       AppLocalizations.of(context)!.translate("Basic"),
//                       style: TextStyle(
//                           color:
//                           Theme.of(context).textTheme.displayLarge!.color,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 5,),
//                     Text('99.99/month',
//                         style: TextStyle(
//                             color: Theme.of(context)
//                                 .textTheme
//                                 .displayLarge!
//                                 .color,
//                             fontSize: 22)),
//                     const SizedBox(height: 5,),
//                     // ListView.builder(
//                     //   shrinkWrap: true,
//                     //   physics: const NeverScrollableScrollPhysics(),
//                     //   itemCount: subscriptions[0].details.length,
//                     //   padding: const EdgeInsets.symmetric(vertical: 10),
//                     //   itemBuilder: (BuildContext context, int index) {
//                     //     return Padding(
//                     //       padding: const EdgeInsets.symmetric(vertical: 2),
//                     //       child: Row(
//                     //         crossAxisAlignment: CrossAxisAlignment.start,
//                     //         mainAxisAlignment: MainAxisAlignment.start,
//                     //         children: [
//                     //           Icon(
//                     //             Icons.check_circle_rounded,
//                     //             size: 18,
//                     //             color: Theme.of(context)
//                     //                 .textTheme
//                     //                 .displayLarge!
//                     //                 .color,
//                     //           ),
//                     //           const SizedBox(
//                     //             width: 5,
//                     //           ),
//                     //           Text(subscriptions[0].details[index],
//                     //               style: TextStyle(
//                     //                   color: Theme.of(context)
//                     //                       .textTheme
//                     //                       .displayLarge!
//                     //                       .color,
//                     //                   fontSize: 16)),
//                     //         ],
//                     //       ),
//                     //     );
//                     //   },
//                     // ),
//                   ],
//                 ),
//               ),
//
//               //Plans
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   AppLocalizations.of(context)!.translate("Plans"),
//                   style: TextStyle(
//                       color:
//                       Theme.of(context).textTheme.displayLarge!.color,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//
//               SubscriptionBlocWidget(sessionHelper: sessionHelper),
//
//               //My Transaction
//               Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Text(
//                   AppLocalizations.of(context)!.translate("My Transaction"),
//                   style: TextStyle(color: Theme.of(context).textTheme.displayLarge!.color,fontWeight: FontWeight.bold,fontSize: 22),
//                 ),
//               ),
//               const SizedBox(height: 20,),
//
//               ListView.builder(
//                   itemCount: list.length,
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemBuilder: (BuildContext context, int index){
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 list[index]['title'],
//                                 style: TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),
//                               ),
//                               Text(
//                                 "${list[index]['amount']}",
//                                 style: TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 5,),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//
//                           child: Text(
//                             AppHelper.dateChange(list[index]['date']),
//                             style: TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),
//                           ),
//                         ),
//                         const SizedBox(height: 10,),
//
//                         if(index != list.length -1)   dividerWidget(),
//                         const SizedBox(height: 10,),
//
//                       ],
//                     );
//                   })
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
