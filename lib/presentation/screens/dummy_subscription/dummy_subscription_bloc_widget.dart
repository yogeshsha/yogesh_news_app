// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:newsapp/constants/app_constant.dart';
// import 'package:newsapp/data/subscription_data/domain/subscription_model/subscription_model.dart';
//
// import '../../../data/subscription_data/subscription_bloc/subscription_bloc.dart';
// class DummySubscriptionBlocWidget extends StatelessWidget {
//   final SessionHelper? sessionHelper;
//   const DummySubscriptionBlocWidget({super.key,required this.sessionHelper});
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SubscriptionBloc, SubscriptionState>
//       (builder: (context, state) {
//       if (state is SubscriptionLoaded) {
//         print(state.details);
//         return ListView.builder(
//           shrinkWrap: true,
//           itemCount: state.details.length,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (BuildContext context, int index) {
//             SubscriptionNewsModel subscription = state.details[index];
//             return Container(
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 color: Theme.of(context).textTheme.bodyLarge!.color,
//                 // color: Colors.white60,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               margin: const EdgeInsets.symmetric(vertical: 10),
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     subscription.name!,
//                     style: TextStyle(
//                         color:
//                             Theme.of(context).textTheme.displayLarge!.color,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 5,),
//                   Text('${subscription.amount} Rs',
//                       style: TextStyle(
//                           color: Theme.of(context)
//                               .textTheme
//                               .displayLarge!
//                               .color,
//                           fontSize: 22)),
//                   const SizedBox(height: 5,),
//                   if(subscription.description != null)
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: subscription.description!.length,
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     itemBuilder: (BuildContext context, int index) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 2),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Icon(
//                               Icons.check_circle_rounded,
//                               size: 18,
//                               color: Theme.of(context)
//                                   .textTheme
//                                   .displayLarge!
//                                   .color,
//                             ),
//                             const SizedBox(
//                               width: 5,
//                             ),
//                             Text(subscription.description![index],
//                                 style: TextStyle(
//                                     color: Theme.of(context)
//                                         .textTheme
//                                         .displayLarge!
//                                         .color,
//                                     fontSize: 16)),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: Colors.grey,
//                         // Text color
//                         elevation: 8.0,
//                         // Elevation
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0), // Button border radius
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 12.0), // Button padding
//                       ),
//                       onPressed:(){
//                         if(sessionHelper == null){
//                           if(sessionHelper!.get(SessionHelper.userId) != null){
//                             Navigator.pop(context);
//                           }else{
//                             Navigator.pushNamed(context, "/login");
//                           }
//                         }else{
//                           Navigator.pushNamed(context, "/login");
//                         }
//                         },
//                       child: Text("Buy Now",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Theme.of(context).textTheme.displayLarge!.color),),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           },
//         );
//       }
//       return const SizedBox();
//     });
//   }
// }
