import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
class BreakingNewsTV extends StatefulWidget {
  final ChewieController controller;
  const BreakingNewsTV({super.key,required this.controller});

  @override
  State<BreakingNewsTV> createState() => _BreakingNewsTVState();
}

class _BreakingNewsTVState extends State<BreakingNewsTV> {
  @override
  void initState() {
    super.initState();
    widget.controller.videoPlayerController.pause();
    _checkAdTime();
  }
  void _checkAdTime() {
    widget.controller.videoPlayerController.play();
    Future.delayed(Duration(seconds: widget.controller.videoPlayerController.value.duration.inSeconds - 2)).then((value) =>Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false) );
  }
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Chewie(
              controller: widget.controller ,
            ),
            Positioned(
              bottom: 10,
                right: 10,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black12
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: const Text(
                      "Skip",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
