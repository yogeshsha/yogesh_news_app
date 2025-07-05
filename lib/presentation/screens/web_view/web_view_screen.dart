// import 'package:flutter/material.dart';
// import 'package:newsapp/presentation/widgets/arrow_back_ios.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// import '../../../utils/app.dart';
//
// // ignore: must_be_immutable
// class WebViewScreen extends StatefulWidget {
//   String url;
//
//   WebViewScreen({super.key, required this.url});
//
//   @override
//   State<WebViewScreen> createState() => _WebViewScreenState();
// }
//
// class _WebViewScreenState extends State<WebViewScreen> {
//   bool isLoading = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           child: Stack(
//             children: [
//               WebViewWidget(
//                 initialUrl: widget.url,
//                 zoomEnabled: false,
//                 debuggingEnabled: false,
//                 javascriptMode: JavascriptMode.unrestricted,
//                 onProgress: (int progress) {
//                   AppHelper.myPrint('WebView is loading (progress : $progress%)');
//                   if(progress == 100){
//                     setState(() {
//                       isLoading = false;
//                     });
//                   }
//                 },
//                 navigationDelegate: (NavigationRequest request) {
//                   if (request.url.startsWith('https://www.youtube.com/')) {
//                     AppHelper.myPrint('blocking navigation to $request}');
//                     return NavigationDecision.prevent;
//                   }
//                   AppHelper.myPrint('allowing navigation to $request');
//                   return NavigationDecision.navigate;
//                 },
//                 onPageStarted: (String url) {
//                   AppHelper.myPrint('Page started loading: $url');
//                 },
//                 onPageFinished: (String url) {
//                   AppHelper.myPrint('Page finished loading: $url');
//                 },
//                 gestureNavigationEnabled: true,
//                 backgroundColor: const Color(0x00000000),
//               ),
//               if(isLoading)
//               const Center(
//                 child: CircularProgressIndicator(),
//               ),
//               Positioned(top: 10, left: 10, child: arrowBack(context))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
