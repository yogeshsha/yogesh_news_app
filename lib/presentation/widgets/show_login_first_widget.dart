import 'package:flutter/material.dart';

import '../screens/live/live_tv_screen.dart';
void showLoginFirst(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text('For Subscription you have to login first'),
          // content: const Text('Please login'),
          actions: <Widget>[
            TextButton(
              child: const Text('Login'),
              onPressed: () {
                if (LiveTvScreenState.videoPlayerController != null) {
                  LiveTvScreenState.videoPlayerController!.pause();
                }
                Navigator.popAndPushNamed(
                  context,
                  "/login",
                ).then((value) {
                  if (LiveTvScreenState.videoPlayerController != null) {
                    LiveTvScreenState.videoPlayerController!.play();
                  }
                });
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );

}