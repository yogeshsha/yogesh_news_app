import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:text_to_speech/text_to_speech.dart';
import '../../../../constants/app_constant.dart';
import '../../../../data/favorite_data/favorite_bloc/favorite_bloc.dart';
import '../../../../utils/app.dart';
import '../../../../utils/app_localization.dart';
import '../../../widgets/elevated_button.dart';
import '../../../widgets/fancy_shimmer_image.dart';
import '../../../widgets/home_widgets.dart';
import '../../like_unlike/like_unlike_widget.dart';

class Favorite extends StatefulWidget {
  // final TextToSpeech tts;

  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  void initState() {
    context.read<FavoriteBloc>().add(FetchFavorite());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
      if (state is FavoriteLoaded) {
        if (state.details.isEmpty) {
          return Center(
            child: Text(
              AppLocalizations.of(context)!.translate("No Favorite Found"),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).textTheme.displayLarge!.color,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          );
        }
        return GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          itemCount: state.details.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              mainAxisSpacing: 12, // Spacing between rows
              crossAxisSpacing: 12, // Spacing between columns
              childAspectRatio: 80 / 100),
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: fancyShimmerImageWidget(
                        state.details[index].news!.posterImage,
                        radius: BorderRadius.circular(10))),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/details",
                        arguments: state.details[index].news!.id.toString());
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                          text1(state.details[index].news!.newsCategory!.name!,
                              context),
                          const SizedBox(
                            height: 6,
                          ),
                          text2(state.details[index].news!.title!),
                          const SizedBox(
                            height: 6,
                          ),
                          text1( AppHelper.dateChange(state.details[index].createdAt!),
                              context),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: LikeUnlikeWidget(
                    isLiked: const [""],
                    id: state.details[index].news!.id.toString(),
                    remove: (id) {
                      for (int i = 0; i < state.details.length; i++) {
                        if (state.details[i].news!.id.toString().trim() == id) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              state.details.removeAt(i);
                            });
                          });
                          break;
                        }
                      }
                    },
                  ),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.volume_up_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // widget.tts.speak(
                        //   state.details[index].news!.title!,
                        // );
                      },
                    )),
              ],
            );
          },
        );
      } else if (state is FavoriteError) {
        if (state.message == "Login Token Expire") {
          SessionHelper().clear();
        }
      }
      return noFavoriteFound(context);
    });
  }

  Widget noFavoriteFound(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.translate("No Favorite Found"),
          style: TextStyle(
              color: Theme.of(context).textTheme.displayLarge!.color,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomElevatedButton(
          text: AppLocalizations.of(context)!.translate("Login"),
          onPressed: () => Navigator.pushNamed(context, "/login").then(
              (value) => context.read<FavoriteBloc>().add(FetchFavorite())),
        ),
      ],
    );
  }
}
