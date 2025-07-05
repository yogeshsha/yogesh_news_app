import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsapp/presentation/widgets/elevated_button.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/app.dart';
import '../../../utils/app_localization.dart';
import '../../../utils/language.dart';
import '../../widgets/headline_expanded_news_widgets.dart';
import '../../widgets/text_field.dart';

class SubmitYourNews extends StatefulWidget {
  const SubmitYourNews({super.key});

  @override
  State<SubmitYourNews> createState() => _SubmitYourNewsState();
}

class _SubmitYourNewsState extends State<SubmitYourNews> {
  final SpeechToText _speechToText = SpeechToText();
  final List<File> _selectedImages = [];
  late VideoPlayerController _controller;
  File? _selectedVideo;
  bool _speechEnabled = false;
  String beforeTextTitle = "";
  String beforeTextDescription = "";
  bool micTitle = false;
  bool micDescription = false;
  int trackTitle = -1;
  int trackDescription = -1;

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  bool check = false;
  ScrollController scrollController = ScrollController();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: appBarWithBackLogoCenterImage(context,AppLocalizations.of(context)!.translate("Submit your news")),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              thickness: 5,
              radius: const Radius.circular(5),
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height:80,
                            child: TextInputField(context, AppLocalizations.of(context)!.translate("Title"), title, 2,
                                validation: (value) {
                              if (value!.isEmpty) {
                              }
                              return null;
                            }),
                          ),
                          if(_speechEnabled)
                            Positioned(
                                bottom: 5,
                                right: 5,
                                child: IconButton(
                                  icon: Icon(
                                    micTitle
                                        ? Icons.volume_up_outlined
                                        :
                                    Icons.volume_off_outlined,
                                    color: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                  ),
                                  onPressed: (){
                                    beforeTextTitle = title.text.trim();
                                    trackTitle = title.selection.baseOffset;
                                    if(micTitle){
                                      _stopListening();
                                      setState(() {
                                        micTitle = false;
                                      });
                                    }else{
                                      _startListening(false);
                                    }

                                    // _speechToText.isNotListening
                                    //     ? _startListening(false)
                                    //     : _stopListening();
                                  },
                                ))
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Stack(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height/1.7,
                            child: TextInputField(context, AppLocalizations.of(context)!.translate("Description"), description, 25,
                                validation: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.translate("Please enter a description");
                              }
                              return null;
                            }),
                          ),
                          if(_speechEnabled)
                          Positioned(
                              bottom: 5,
                              right: 5,
                              child: IconButton(
                                icon: Icon(
                                  micDescription
                                      ? Icons.volume_up_outlined
                                      :
                                  Icons.volume_off_outlined,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color,
                                ),
                                onPressed: (){
                                  beforeTextDescription = description.text.trim();
                                  trackDescription = description.selection.baseOffset;

                                  if(micDescription){
                                    _stopListening();
                                    setState(() {
                                      micDescription = false;
                                    });
                                  }else{
                                    _startListening(true);
                                  }
                                  // _speechToText.isNotListening
                                  //     ? _startListening(true)
                                  //     : _stopListening();
                                },
                              ))
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2 - 30,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomElevatedButton(
                                      text: AppLocalizations.of(context)!.translate("Upload Video"),
                                      onPressed: () {
                                        _showPicker(context, true);
                                      }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (_selectedVideo != null)
                                    AspectRatio(
                                      aspectRatio:
                                          (MediaQuery.of(context).size.width /
                                                  2) /
                                              300,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedVideo = null;
                                              _controller.dispose();
                                            });
                                          },
                                          child: Stack(
                                            children: [
                                              VideoPlayer(_controller),
                                              Positioned(
                                                  top: 5,
                                                  right: 5,
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30),
                                                        color: Colors.red),
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2 - 30,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomElevatedButton(
                                      text: AppLocalizations.of(context)!.translate("Upload Images"),
                                      onPressed: () {
                                        _showPicker(context, false);
                                      }),
                                  ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemCount: _selectedImages.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          height: 200,
                                          width:
                                              MediaQuery.of(context).size.width /
                                                      2 -
                                                  30,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectedImages.removeAt(index);
                                              });
                                            },
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                    top: 0,
                                                    bottom: 0,
                                                    left: 0,
                                                    right: 0,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.file(
                                                          _selectedImages[index],
                                                          fit: BoxFit.fill),
                                                    )),
                                                Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: Colors.red),
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox(height: 16.0),
                      // if (_selectedVideo != null)
                      //   AspectRatio(
                      //     aspectRatio: _controller.value.aspectRatio,
                      //     child: GestureDetector(
                      //       onTap: () {
                      //         setState(() {
                      //           _selectedVideo = null;
                      //           _controller.dispose();
                      //         });
                      //       },
                      //       child: Stack(
                      //         children: [
                      //           VideoPlayer(_controller),
                      //           Positioned(
                      //               top: 1,
                      //               right: 1,
                      //               child: Container(
                      //                 height: 30,
                      //                 width: 30,
                      //                 decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.circular(30),
                      //                     color: Colors.red),
                      //                 child: const Center(
                      //                   child: Icon(
                      //                     Icons.remove,
                      //                     color: Colors.white,
                      //                   ),
                      //                 ),
                      //               ))
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // const SizedBox(height: 16.0),
                      // CustomElevatedButton(
                      //     text: "Select Images",
                      //     onPressed: () {
                      //       _showPicker(context, false);
                      //     }),
                      // const SizedBox(height: 16.0),
                      // GridView.builder(
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   shrinkWrap: true,
                      //   padding: EdgeInsets.zero,
                      //   itemCount: _selectedImages.length,
                      //   gridDelegate:
                      //       const SliverGridDelegateWithFixedCrossAxisCount(
                      //           crossAxisCount: 3, // Number of columns
                      //           mainAxisSpacing: 12, // Spacing between rows
                      //           crossAxisSpacing: 12, // Spacing between columns
                      //           childAspectRatio: 1),
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return GestureDetector(
                      //       onTap: () {
                      //         setState(() {
                      //           _selectedImages.removeAt(index);
                      //         });
                      //       },
                      //       child: Stack(
                      //         children: [
                      //           Positioned(
                      //               top: 0,
                      //               bottom: 0,
                      //               left: 0,
                      //               right: 0,
                      //               child: Image.file(_selectedImages[index],
                      //                   fit: BoxFit.fill)),
                      //           Positioned(
                      //               top: 1,
                      //               right: 1,
                      //               child: Container(
                      //                 height: 30,
                      //                 width: 30,
                      //                 decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.circular(30),
                      //                     color: Colors.red),
                      //                 child: const Center(
                      //                   child: Icon(
                      //                     Icons.remove,
                      //                     color: Colors.white,
                      //                   ),
                      //                 ),
                      //               ))
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // ),
                      const SizedBox(height: 40.0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 10,
                left: 20,
                right: 20,
                child: CustomElevatedButton(
                    text: AppLocalizations.of(context)!.translate("Save"),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (_selectedImages.isEmpty && _selectedVideo == null) {
                          AppHelper.showSnakeBar(
                              context,  AppLocalizations.of(context)!.translate("Select Image or Add one Video"));
                        } else {
                          if (_selectedVideo != null) {
                            // MediaInfo? mediaInfo =
                            //     await VideoCompress.compressVideo(
                            //   _selectedVideo!.path,
                            //   quality: VideoQuality.DefaultQuality,
                            //   deleteOrigin: false, // It's false by default
                            // );
                            // print(
                            //     "Size  --------------------- ${mediaInfo!.filesize}");
                          }
                          Navigator.pop(context);
                        }
                      }
                    }))
          ],
        ),
      ),
    );
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {

    });
  }
  void resultListener(SpeechRecognitionResult result) {
    AppHelper.myPrint(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    AppHelper.myPrint('${result.recognizedWords} - ${result.finalResult}');

  }
  /// Each time to start a speech recognition session
  void _startListening(bool check) async {
    bool onDevice = false;
    AppHelper.myPrint("------------ Local ------------");
    AppHelper.myPrint(await AppLanguage().fetchLocale());
    AppHelper.myPrint("------------------------");
    String currentLocaleId = await AppLanguage().fetchLocale();
    // String currentLocaleId = 'en_IN';
    // var locales = await _speechToText.locales();
    // for(int i = 0;i<locales.length;i++) {
    //   print("---------------- Local $i --------------");
    //   print(locales[i].name);
    //   print(locales[i].localeId);
    //   print("------------------------------");
    // }

    // Some UI or other code to select a locale from the list
    // resulting in an index, selectedLocale

    // _speechToText.listen(
    //   onResult: resultListener,
    //   localeId: selectedLocale.localeId,
    // );
    // final pauseFor = int.tryParse(_pauseForController.text);
    // final listenFor = int.tryParse(_listenForController.text);
    _speechToText.cancel();
    setState(() {
      micDescription = false;
      micTitle = false;
      check ? micDescription = true : micTitle = true;
    });
    _speechToText.listen(
      onResult:  check ? _onSpeechResult : _onSpeechResult1,
      // listenFor: const Duration(seconds: 60),
      partialResults: true,

      localeId: currentLocaleId,
      cancelOnError: true,
      listenMode: ListenMode.confirmation,
      onDevice: onDevice,
    );
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {

    if(result.finalResult) {
      if(trackDescription > -1){
        final newText = beforeTextDescription.replaceRange(
            trackDescription, trackDescription, result.recognizedWords);
        description.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(
              offset: trackDescription + result.recognizedWords.length),
        );
      }else if (beforeTextDescription.isNotEmpty) {
        setState(() {
          description = TextEditingController(text: "$beforeTextDescription ${result.recognizedWords}");
        });
      } else {
        setState(() {
          description = TextEditingController(text: result.recognizedWords);
        });
      }
      setState(() {
        micDescription = false;
      });
    }
    else{
      if(trackDescription > -1){
        final newText = beforeTextDescription.replaceRange(
            trackDescription, trackDescription, result.recognizedWords);
        description.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(
              offset: trackDescription + result.recognizedWords.length),
        );
      }else
      if (beforeTextDescription.isNotEmpty) {
        setState(() {
          description = TextEditingController(text: "$beforeTextDescription ${result.recognizedWords}");
        });
      } else {
        setState(() {
          description = TextEditingController(text: result.recognizedWords);
        });
      }
    }
  }
  void _onSpeechResult1(SpeechRecognitionResult result) {
    if(result.finalResult) {
      if(trackTitle > -1){
        final newText = beforeTextTitle.replaceRange(
            trackTitle, trackTitle, result.recognizedWords);
        title.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(
              offset: trackTitle + result.recognizedWords.length),
        );
      }else if (beforeTextTitle.isNotEmpty) {
        setState(() {
          title = TextEditingController(text: "$beforeTextTitle ${result.recognizedWords}");
        });
      } else {
        setState(() {
          title = TextEditingController(text: result.recognizedWords);
        });
      }
      setState(() {
        micTitle = false;
      });
    }else{
      if(trackTitle > -1){
        final newText = beforeTextTitle.replaceRange(
            trackTitle, trackTitle, result.recognizedWords);
        title.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(
              offset: trackTitle + result.recognizedWords.length),
        );
      }else if (beforeTextTitle.isNotEmpty) {
        setState(() {
          title = TextEditingController(text: "$beforeTextTitle ${result.recognizedWords}");
        });
      } else {
        setState(() {
          title = TextEditingController(text: result.recognizedWords);
        });
      }
    }
  }

  void _showPicker(context, bool check) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: Text(AppLocalizations.of(context)!.translate("Library")),
                    onTap: () {
                      check ? _videoFromGallery() : _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: Text(AppLocalizations.of(context)!.translate("Camera")),
                  onTap: () {
                    check ? _videoFromCamara() : _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _imgFromCamera() async {
    XFile? selectedImages =
        await ImagePicker().pickImage(source: ImageSource.camera,);
    if (selectedImages != null) {
      setState(() {
        _selectedImages.add(File(selectedImages.path));
      });
    }
  }

  _imgFromGallery() async {
    List<XFile>? selectedImages = await ImagePicker().pickMultiImage();
    AppHelper.convertImageToWebP(selectedImages.first.path);
    setState(() {
      _selectedImages.addAll(selectedImages.map((e) => File(e.path)).toList());
    });
    // for(int i = 0 ;i<selectedImages.length;i++){
    //   print("-------------------- Image $i -----------------");
    //   print(await textPicker(File(selectedImages[i].path).path));
    //   print("-------------------------------------");
    //
    // }
  }

  _videoFromGallery() async {
    XFile? selectedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (selectedVideo != null) {
      final bytes = (await selectedVideo.readAsBytes()).lengthInBytes;
      final kb = bytes / 1024;
      final mb = kb / 1024;
      if (mb > 100) {
        if (mounted) {
          AppHelper.showSnakeBar(context, AppLocalizations.of(context)!.translate("Not more than 100 MB"));
        }
      } else {
        _controller = VideoPlayerController.file(File(selectedVideo.path))
          ..initialize().then((_) {
            setState(() {});
            _controller.setLooping(true);
            _controller.play();
          });
        setState(() {
          _selectedVideo = File(selectedVideo.path);
          // _selectedVideo.add(File(selectedVideo.path));
        });
      }
    }
  }

  _videoFromCamara() async {
    XFile? selectedVideo =
        await ImagePicker().pickVideo(source: ImageSource.camera);
    if (selectedVideo != null) {
      _controller = VideoPlayerController.file(File(selectedVideo.path))
        ..initialize().then((_) {
          setState(() {});
          _controller.play();
        });
      setState(() {
        _selectedVideo = File(selectedVideo.path);
        // _selectedVideo.add(File(selectedVideo.path));
      });
    }
  }
}
