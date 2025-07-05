import 'package:flutter/material.dart';
import 'package:webfeed_plus/domain/rss_feed.dart';
import 'package:http/http.dart' as http;
import '../../../utils/app.dart';
import '../../widgets/home_widgets.dart';
class FeedBlocScreen extends StatefulWidget {
  final  String url;
  final  Function before;
  final  Function(bool) after;
     const FeedBlocScreen({super.key,required this.before, required this.after,required this.url});

  @override
  State<FeedBlocScreen> createState() => _FeedBlocScreenState();
}

class _FeedBlocScreenState extends State<FeedBlocScreen> {
  RssFeed? _feed;

  @override
  void initState() {
    loadFeed();
    // TODO: implement initState
    super.initState();
  }
  Future<void> loadFeed() async {
    try {
      final response = await http.get(Uri.parse(widget.url));
      setState(() {
        _feed = RssFeed.parse(response.body);
      });
    } catch (e) {
      AppHelper.myPrint("------------ E ---------------");
      AppHelper.myPrint(e.toString());
      AppHelper.myPrint("---------------------------");
    }
  }
  @override
  Widget build(BuildContext context) {

    return _feed != null ? Container(
      color: Theme.of(context).cardColor,
      child: GridView.builder(
        shrinkWrap: true,
        padding:
        const EdgeInsets.symmetric( horizontal: 10),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _feed!.items!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            mainAxisSpacing: 12, // Spacing between rows
            crossAxisSpacing: 12, // Spacing between columns
            childAspectRatio: 80 / 100),
        itemBuilder: (BuildContext context, int index) {
          final item = _feed!.items![index];
          return InkWell(
            onTap: () {
              // bool check = widget.before();
              // Navigator.pushNamed(context, "/webView",
              //     arguments: item.link)
              //     .then((value) {
              //   widget.after(check);
              // });
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: Theme.of(context).cardColor,

                  // Image border
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 0,
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 12),
                // padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Spacer(),
                    const SizedBox(
                      height: 6,
                    ),
                    text2(item.title!),
                    const SizedBox(
                      height: 6,
                    ),
                    text1( AppHelper.dateChange2(item.pubDate!), context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ):const SizedBox();
  }
}
