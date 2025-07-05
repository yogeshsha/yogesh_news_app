import 'package:flutter/material.dart';
import 'package:newsapp/presentation/screens/details/details_template_image.dart';
import 'package:newsapp/presentation/widgets/ads_widget.dart';

import '../../../constants/ads_helps.dart';


// ignore: must_be_immutable
class DetailStoriesScreen extends StatefulWidget {
  String id;

  DetailStoriesScreen({super.key, required this.id});

  @override
  State<DetailStoriesScreen> createState() => _DetailStoriesScreenState();
}

class _DetailStoriesScreenState extends State<DetailStoriesScreen> with TickerProviderStateMixin{
  List<Story> stories = [
    Story(
        imageUrl:
            "https://media.istockphoto.com/id/1093110112/photo/picturesque-morning-in-plitvice-national-park-colorful-spring-scene-of-green-forest-with-pure.jpg?s=612x612&w=0&k=20&c=lpQ1sQI49bYbTp9WQ_EfVltAqSP1DXg0Ia7APTjjxz4=",
        title:
            "DEMO sfl;aksdfjflsdkfjklsdfjkl;asflk;dsfjkl;dsfklsdajfklsdjfkl;asjfkl;sdfjkldfjkladsjfkldsflk;asfsakl;fsdlkajlasdl;kfnlkdsafklsdajfkl;sdfklsadflaksfjkl;safjaslkjlk"),
    Story(
        imageUrl:
            "https://media.istockphoto.com/id/1093110112/photo/picturesque-morning-in-plitvice-national-park-colorful-spring-scene-of-green-forest-with-pure.jpg?s=612x612&w=0&k=20&c=lpQ1sQI49bYbTp9WQ_EfVltAqSP1DXg0Ia7APTjjxz4=",
        title:
            "DEMO sfl;aksdfjflsdkfjklsdfjkl;asflk;dsfjkl;dsfklsdajfklsdjfkl;asjfkl;sdfjkldfjkladsjfkldsflk;asfsakl;fsdlkajlasdl;kfnlkdsafklsdajfkl;sdfklsadflaksfjkl;safjaslkjlk"),
    Story(
        imageUrl:
            "https://media.istockphoto.com/id/1093110112/photo/picturesque-morning-in-plitvice-national-park-colorful-spring-scene-of-green-forest-with-pure.jpg?s=612x612&w=0&k=20&c=lpQ1sQI49bYbTp9WQ_EfVltAqSP1DXg0Ia7APTjjxz4=",
        title:
            "DEMO sfl;aksdfjflsdkfjklsdfjkl;asflk;dsfjkl;dsfklsdajfklsdjfkl;asjfkl;sdfjkldfjkladsjfkldsflk;asfsakl;fsdlkajlasdl;kfnlkdsafklsdajfkl;sdfklsadflaksfjkl;safjaslkjlk"),
    Story(
        imageUrl:
            "https://media.istockphoto.com/id/1093110112/photo/picturesque-morning-in-plitvice-national-park-colorful-spring-scene-of-green-forest-with-pure.jpg?s=612x612&w=0&k=20&c=lpQ1sQI49bYbTp9WQ_EfVltAqSP1DXg0Ia7APTjjxz4=",
        title:
            "DEMO sfl;aksdfjflsdkfjklsdfjkl;asflk;dsfjkl;dsfklsdajfklsdjfkl;asjfkl;sdfjkldfjkladsjfkldsflk;asfsakl;fsdlkajlasdl;kfnlkdsafklsdajfkl;sdfklsadflaksfjkl;safjaslkjlk"),
    Story(
        imageUrl:
            "https://media.istockphoto.com/id/1093110112/photo/picturesque-morning-in-plitvice-national-park-colorful-spring-scene-of-green-forest-with-pure.jpg?s=612x612&w=0&k=20&c=lpQ1sQI49bYbTp9WQ_EfVltAqSP1DXg0Ia7APTjjxz4=",
        title:
            "DEMO sfl;aksdfjflsdkfjklsdfjkl;asflk;dsfjkl;dsfklsdajfklsdjfkl;asjfkl;sdfjkldfjkladsjfkldsflk;asfsakl;fsdlkajlasdl;kfnlkdsafklsdajfkl;sdfklsadflaksfjkl;safjaslkjlk"),
    Story(
        imageUrl:
            "https://media.istockphoto.com/id/1093110112/photo/picturesque-morning-in-plitvice-national-park-colorful-spring-scene-of-green-forest-with-pure.jpg?s=612x612&w=0&k=20&c=lpQ1sQI49bYbTp9WQ_EfVltAqSP1DXg0Ia7APTjjxz4=",
        title:
            "DEMO sfl;aksdfjflsdkfjklsdfjkl;asflk;dsfjkl;dsfklsdajfklsdjfkl;asjfkl;sdfjkldfjkladsjfkldsflk;asfsakl;fsdlkajlasdl;kfnlkdsafklsdajfkl;sdfklsadflaksfjkl;safjaslkjlk"),
    Story(
        imageUrl:
            "https://media.istockphoto.com/id/1093110112/photo/picturesque-morning-in-plitvice-national-park-colorful-spring-scene-of-green-forest-with-pure.jpg?s=612x612&w=0&k=20&c=lpQ1sQI49bYbTp9WQ_EfVltAqSP1DXg0Ia7APTjjxz4=",
        title:
            "DEMO sfl;aksdfjflsdkfjklsdfjkl;asflk;dsfjkl;dsfklsdajfklsdjfkl;asjfkl;sdfjkldfjkladsjfkldsflk;asfsakl;fsdlkajlasdl;kfnlkdsafklsdajfkl;sdfklsadflaksfjkl;safjaslkjlk"),
  ];
  int _currentStoryIndex = 0;
  AnimationController? _animationController;
  // Animation<double>? _nextPage;
  int _currentPage = 0;
  bool showAd = false;
  late PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    _animationController =
    AnimationController(vsync: this, duration: const Duration(seconds: 8));
    // _nextPage = Tween(begin: 0.0, end: 1.0).animate(_animationController!);
    _animationController!.addListener(_listener);
    _animationController!.addListener(_listener1);
    super.initState();
  }

  _listener() {
    if (_animationController!.status == AnimationStatus.completed) {
      _animationController!.reset(); //Reset the controller
      int page = stories.length - 1; //Number of pages in your PageView
      if (_currentPage < page) {
        setState(() {
          _currentPage++;
          _pageController.animateToPage(_currentPage,
              duration: const Duration(milliseconds: 300), curve: Curves.easeInSine);
        });
      } else {
        _currentPage = 0;
      }
    }

    // print("----as");
    // setState(() {
    //   if (_pageController.position.userScrollDirection !=
    //       ScrollDirection.reverse) {
    //     if (_pageController.page! < 1) {
    //       // print("---c--${_pageController.position}");
    //       // print("---c--${_pageController.position.hasPixels}");
    //       // print("---c--${_pageController.page!.toInt()}");
    //       // _pageController.removeListener(_listener);
    //       // Navigator.pop(context);
    //     }
    //   }
    // });
  }

  _listener1(){
    if(_currentPage == 2){
      setState(() {
        showAd = true;
      });
      _animationController!.removeListener(_listener);
      _animationController!.removeListener(_listener1);
    }
  }


  @override
  void dispose() {
    _animationController!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController!.forward();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:
          showAd ? Stack(
            children: [
              TestBanner(adId:AdWidgetUrls.fixedSizeBannerAd,height: MediaQuery.of(context).size.height.toInt() -100,width: MediaQuery.of(context).size.width.toInt(),),
              Positioned(
                top: 4,
                  left: 4,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close,color: Colors.white,),
                      onPressed: (){
                        setState(() {
                          showAd = false;
                          _pageController = PageController(
                            initialPage: _currentPage,
                          );
                        });
                        _animationController!.addListener(_listener);
                      },
                    ),
                  )
              )
            ],
          ) :

          Stack(
            children: [
              PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                itemCount: stories.length,

                allowImplicitScrolling: true,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                    _currentStoryIndex = index;
                    _animationController!.forward();

                  });
                },
                itemBuilder: (context, index) {
                  return DetailsImageTemplate(
                      image: stories[index].imageUrl, text: stories[index].title);
                },
              ),
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    stories.length,
                    (index) => _buildStoryIndicator(index),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoryIndicator(int index) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentStoryIndex == index ? Colors.white : Colors.grey,
      ),
    );
  }
}

class Story {
  final String imageUrl;
  final String title;

  Story({required this.imageUrl, required this.title});
}
//
// @override
// Widget build(BuildContext context) {
//
//   return Scaffold(
//     backgroundColor: Theme.of(context).primaryColor,
//     body: SizedBox(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       child: Stack(
//         children: [
//           PageView.builder(
//             physics: const BouncingScrollPhysics(),
//             controller: _pageController,
//             itemCount: stories.length,
//             allowImplicitScrolling: true,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentStoryIndex = index;
//               });
//             },
//             itemBuilder: (context, index) {
//               return DetailsImageTemplate(
//                   image: stories[index].imageUrl, text: stories[index].title);
//             },
//           ),
//           // Positioned(top: 35, left: 5, child: arrowBack(context)),
//           Positioned(
//             bottom: 16,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 stories.length,
//                     (index) => _buildStoryIndicator(index),
//               ),
//             ),
//           ),
//           // logoStick(onTap: () {
//           //   Navigator.pop(context);
//           //   changeToHomeScreen(context, controller);
//           // }),
//
//           // Positioned(
//           //     right: 0,
//           //     top: 40,
//           //     child: InkWell(
//           //       onTap: () {
//           //         Navigator.pop(context);
//           //         changeToHomeScreen(context, controller);
//           //       },
//           //       child: Image.asset(
//           //         "assets/logo2.png",
//           //         width: 70,
//           //         height: 40,
//           //         fit: BoxFit.fill,
//           //       ),
//           //     ))
//         ],
//       ),
//     ),
//   );
// }