import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:newsapp/data/detail_page_data/domain/detail_model/detail_model.dart';
import 'package:newsapp/presentation/widgets/stick_logo.dart';
// import 'package:text_to_speech/text_to_speech.dart';

import '../../../constants/app_constant.dart';
import '../../../data/detail_page_data/detail_bloc/detail_bloc.dart';
import '../../../data/detail_page_data/domain/usecases/detail_usecase_interface.dart';
import '../../../data/detail_page_data/repo/detail_impl.dart';
import '../../../utils/app.dart';
import '../../widgets/arrow_back_ios.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/fancy_shimmer_image.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  String id;

  DetailsScreen({super.key, required this.id});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>{
  DetailModel? model;
  final detailRepository = DetailRepositoryImpl();
  late DetailUseCase detailUseCase;
  SessionHelper? sessionHelper;
  // TextToSpeech tts = TextToSpeech();
  bool mute = false;

  @override
  void initState() {
    initSession();
    // tts.setPitch(10);
    // tts.setRate(0.7);
    detailUseCase = DetailUseCase(detailRepository: detailRepository);
    super.initState();
  }

  void initSession() async {
    sessionHelper = await SessionHelper.getInstance(context);
    setState(() {});
  }
  @override
  void dispose() {
    // TODO: implement dispose
    // tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<DetailBloc>.call().add(FetchDetail(id: widget.id));
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          BlocBuilder<DetailBloc, DetailState>(builder: (context, state) {
            if (state is DetailLoaded) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Stack(
                  children: [
                    SizedBox(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height,
                        child: fancyShimmerImageWidget(
                            state.details.posterImage)),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                          color: Theme.of(context).primaryColor
                      ),
                      // width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height - 350,
                      margin : const EdgeInsets.only(top : 350),
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                              state.details.title!,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                  height: 1.5),
                              maxLines: 3,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                              state.details.shortDescription!,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                  height: 1.5),
                              maxLines: 3,
                            ),
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding:
                              const EdgeInsets.symmetric(horizontal: 15),
                              shrinkWrap: true,
                              itemCount: state.details.description!.length,
                              itemBuilder: (context, index) {
                                if (state.details.description![index].type ==
                                    "text") {
                                  return Stack(
                                    children: [
                                      Html(
                                          shrinkWrap: true,
                                          data: AppHelper.htmlContent(
                                              state
                                                  .details.description![index].val!,
                                              context)),
                                      Positioned(
                                          top : 0,
                                          right : 0,
                                          child: IconButton(
                                            icon: Icon(
                                              mute ? Icons.volume_off_outlined : Icons.volume_up_outlined,color: Colors.white,),
                                            onPressed: (){
                                              // mute ? tts.stop() :
                                              // tts.speak(state.details.description![index].val!,);
                                              // setState(() {
                                              //   mute = !mute;
                                              // });
                                            },
                                          )
                                      ),
                                    ],
                                  );
                                } else {
                                  return fancyShimmerImageWidget(
                                      state.details.description![index].val,
                                      radius: BorderRadius.circular(10));
                                }
                              }),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                              "#clear #html #css",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                  height: 1.5),
                              // maxLines: 3,
                            ),
                          ),
                          // Html(shrinkWrap: true, data: htmlContent(state.details.description![0].val!)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is DetailError) {
              return errorWidget(context, state.message);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
          logoStick(onTap: () {
            Navigator.pop(context);
          }),
          Positioned(top: 35, left: 5, child: arrowBack(context)),
          Positioned(
              top: 45,
              right: 75,
              child: sessionHelper == null
                  ? const SizedBox()
                  : sessionHelper!.get(SessionHelper.userId) == null
                      ? const SizedBox()
                      : menu())
        ],
      ),
    );
  }

  Widget menu() {
    return PopupMenuButton(
        // color: Theme.of(context).primaryColor,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        onSelected: (value) {
          if (value == "complain") {
            Navigator.pushNamed(context, "/complain");
          }
        },
        itemBuilder: (context) => [
              AppHelper.item(context, "Complain", Icons.report_problem_outlined,
                  "complain"),
            ],
        child: const Icon(Icons.more_vert_outlined));
  }
}
