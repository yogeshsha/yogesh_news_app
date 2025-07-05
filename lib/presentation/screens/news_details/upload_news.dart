import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsapp/constants/colors_constants.dart';
import 'package:newsapp/constants/images_constants.dart';
import 'package:newsapp/presentation/screens/news_details/your_news_function.dart';
import 'package:newsapp/presentation/widgets/ink_well_custom.dart';
import 'package:newsapp/presentation/widgets/loader.dart';
import 'package:newsapp/presentation/widgets/primary_button_component.dart';
import 'package:newsapp/presentation/widgets/refresh_widget.dart';
import 'package:newsapp/presentation/widgets/text_form_field.dart';
import 'package:newsapp/utils/app.dart';
import 'package:newsapp/utils/image_builder.dart';
import '../../../constants/app_constant.dart';
import '../../../constants/common_model/key_value_model.dart';
import '../../../data/category_data/category_bloc/category_bloc.dart';
import '../../../data/category_data/domain/category_model/all_news_model.dart';
import '../../../data/category_data/domain/category_model/news_category_model.dart';
import '../../widgets/drop_down_widget.dart';
import '../../widgets/text_common.dart';
import '../../widgets/video_screen_component.dart';
import '../setting/component/common_app_bar_component.dart';

class UploadNewsScreen extends StatefulWidget {
  final List<NewsCategoryModel> categoryList;
  final int newsId;

  const UploadNewsScreen(
      {super.key, required this.categoryList, required this.newsId});

  @override
  State<UploadNewsScreen> createState() => _UploadNewsScreenState();
}

class _UploadNewsScreenState extends State<UploadNewsScreen> {

  String? categoryType;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  bool checkError = true;
  AllNewsModel? newsModel;

  List<DropdownMenuItem<String>> list = [];

  List<Either<XFile, String>> mediaList = [];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.newsId != 0) {
      callYourNewsDetailApi(context);
    } else {
      setData(context);
    }
    super.initState();
  }

  void setData(BuildContext context) {
    list.clear();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      widget.categoryList.map((e) {
        if ((e.id ?? 0) > 0) {
          list.add(DropdownMenuItem(
              value: (e.id ?? 0).toString(),
              child: TextAll(
                textDynamic: true,
                text: AppHelper.getHindiEnglishText( e.name,e.hindiName),
                color: Theme.of(context).colorScheme.secondary,
                weight: FontWeight.w400,
                max: 14,
              )));
        }
      }).toList();
    });
  }

  void callInitialCategory(BuildContext context) {
    context.read<CategoryBloc>().add(const FetchInitialCategory());
  }

  void callPostNews(BuildContext context) {
    List<KeyValueModel> uploadFilesList = [];

    Map map = {
      "title": titleController.text.trim().toString(),
      "newsCategoryId": int.tryParse(categoryType ?? "") ?? 0,
      "shortDescription": descriptionController.text.trim().toString(),
    };
    List<String> otherUrls = [];

    mediaList.map((e) {
      if (e.isLeft) {
        uploadFilesList.add(KeyValueModel(
            key: "userNewsMedia", value: e.left.path, fileName: e.left.path));
      } else {
        otherUrls.add(e.right);
      }
    }).toList();
    if(widget.newsId != 0){
      map["media"] = otherUrls;
    }

    // if (otherUrls.isNotEmpty) {
    // }
    context.read<CategoryBloc>().add(
        PushNewsEvent(id: widget.newsId, body: map, media: uploadFilesList));
  }

  void callYourNewsDetailApi(BuildContext context) {
    String screenName = "YourNewsDetail";
    context
        .read<CategoryBloc>()
        .add(FetchNewsDetailEvent(id: widget.newsId, screenName: screenName));
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      if (state is CategoryLoading) {
        isLoading = true;
        checkError = true;
      } else if (state is CategoryInitial) {
        isLoading = false;
        checkError = true;
      } else if (state is CategoryError) {
        categoryError(context, state);
      } else if (state is OtherStatusCodeCategoryLoaded) {
        otherStatusCodeCategory(context, state);
      } else if (state is PushNewsLoaded) {
        pushNewsLoaded(context, state);
      } else if (state is GetNewsDetailLoaded) {
        getNewsDetailLoaded(context, state);
      }
      return Stack(
        children: [
          Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: Form(
              key: formKey,
              child: SafeArea(
                child: SizedBox(
                  width: mediaWidth,
                  height: mediaHeight,
                  child: Column(
                    children: [
                      CommonAppBarComponent(
                          title: widget.newsId != 0
                              ? "Update News"
                              : "Upload News"),
                      SizedBox(
                        height: mediaHeight * .01,
                      ),
                      Expanded(
                        child: widget.newsId != 0
                            ? RefreshComponent(
                                onRefresh: () {
                                  callYourNewsDetailApi(context);
                                },
                                child: body(context))
                            : body(context),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isLoading) const Loading()
        ],
      );
    });
  }

  Widget body(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            DropDownWidget(
              hintDynamic: true,
              radius: 10,
              initialValue: categoryType,
              items: list,
              onChange: (value) {
                categoryType = value;
                setState(() {});
              },
              compulsory: true,
              hint: "Select Category",
              initialHint: "Select Category",
              suffix: Container(
                margin: const EdgeInsets.only(right: 0),
                color: ColorsConstants.textFieldColor,
                height: 20,
                width: 1,
              ),
            ),
            TextFormFieldWidget(
                borderCurve: 10,
                hint: "Title",
                maxLength: 500,
                controller: titleController,
                validation: (value) {
                  if (value.trim().isEmpty) {
                    return "Enter Title";
                  }
                  return null;
                }),
            TextFormFieldWidget(
                margin: const EdgeInsets.only(bottom: 10),
                borderCurve: 10,
                hint: "About News",
                maxLength: 1000,
                maxLines: 6,
                controller: descriptionController,
                validation: (value) {
                  if (value.trim().isEmpty) {
                    return "Enter About News";
                  }
                  return null;
                }),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.symmetric(vertical: 40),
              width: mediaWidth,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                border: Border.all(
                    color: Theme.of(context).colorScheme.surface, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImagesConstants.downLoadCloud,
                    colorFilter: AppConstant.getColorFilter(
                        Theme.of(context).secondaryHeaderColor),
                  ),
                  SizedBox(
                    height: mediaWidth * .03,
                  ),
                  TextAll(
                      text: "Upload Your Video or Photo here",
                      weight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                      max: 14),
                  TextAll(
                      text: "Files supported: JPG, PNG, GIF, MP4",
                      weight: FontWeight.w500,
                      color: ColorsConstants.textGrayColor,
                      max: 12),
                  PrimaryButtonComponent(
                      margin: EdgeInsets.symmetric(
                          vertical: 12, horizontal: mediaWidth * .17),
                      allowBorder: true,
                      backGroundColor: Colors.transparent,
                      borderColor: Theme.of(context).secondaryHeaderColor,
                      textColor: Theme.of(context).secondaryHeaderColor,
                      title: "Browse files",
                      onTap: () {
                        YourNewsFunction.onTapShare(
                            context: context,
                            onSelectFile: (XFile file) {
                              mediaList.add(Left(file));
                              setState(() {});
                            });
                      }),
                  TextAll(
                      text: "Maximum size: 10MB",
                      weight: FontWeight.w500,
                      color: ColorsConstants.textGrayColor,
                      max: 12),
                ],
              ),
            ),
            Column(
              children: mediaList.map((e) {
                return Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.onSurface),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: getImageVideo(e))),
                      Positioned(
                          top: 0,
                          left: 0,
                          child: InkWellCustom(
                            onTap: () {
                              mediaList.remove(e);
                              setState(() {});
                            },
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Theme.of(context).colorScheme.secondary,
                                size: 18,
                              ),
                            ),
                          ))
                    ],
                  ),
                );
              }).toList(),
            ),
            PrimaryButtonComponent(
                margin: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                title: "${widget.newsId != 0 ? "Update" : "Post"} News",
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (categoryType == null) {
                      AppHelper.showSnakeBar(context, "Select Category");
                    } else if (mediaList.isEmpty) {
                      AppHelper.showSnakeBar(
                          context, "Upload At Least 1 Media");
                    } else {
                      callPostNews(context);
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget getImageVideo(Either<XFile, String> e) {
    if (e.isRight) {
      String extension = e.right.split(".").last;
      if (AppConstant.imageExtension.contains(extension)) {
        return SizedBox(
          child: ImageBuilder.imageBuilderWithoutContainer(e.right),
        );
      }
      if (AppConstant.videoExtension.contains(extension)) {
        return VideoPlayerComponent(url: e.right);
      }

      return const SizedBox();
    } else {
      String extension = e.left.path.split(".").last;
      if (AppConstant.imageExtension.contains(extension)) {
        return SizedBox(
          child: Image.file(
            File(e.left.path),
            fit: BoxFit.fill,
          ),
        );
      }
      if (AppConstant.videoExtension.contains(extension)) {
        return VideoPlayerComponent(url: e.left.path, isLocal: true);
      }
      return const SizedBox();
    }
  }

  void otherStatusCodeCategory(
      BuildContext context, OtherStatusCodeCategoryLoaded state) {
    callInitialCategory(context);

    AppHelper.myPrint(
        "----------------- Inside Other Status Code Category -----------");
    if (checkError) {
      checkError = false;
      if (state.details.statusCode == 401 || state.details.statusCode == 403) {
        Map map = {};
        map['check'] = true;
        map['hideSocialLogin'] = false;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, "/sessionExpired")
              .then((value) => callInitialCategory(context));
        });
      } else if (state.details.statusCode == 500) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, "/connectionTimeout", arguments: true)
              .then((value) => callInitialCategory(context));
        });
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          AppHelper.showSnakeBar(
              context, AppConstant.errorMessage(state.details.message ?? ""));
        });
      }
    }
  }

  void categoryError(BuildContext context, CategoryError state) {
    if (checkError) {
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppHelper.showSnakeBar(
            context, AppConstant.errorMessage(state.message));
      });
    }
    callInitialCategory(context);
  }

  void pushNewsLoaded(BuildContext context, PushNewsLoaded state) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AppHelper.showSnakeBar(context, AppConstant.errorMessage(state.message));
      Navigator.pop(context);
    });
    callInitialCategory(context);
  }

  void getNewsDetailLoaded(BuildContext context, GetNewsDetailLoaded state) {
    callInitialCategory(context);
    newsModel = state.details;
    if (state.details.newsCategory != null) {
      categoryType = (state.details.newsCategory!.id ?? 0).toString();
    }
    mediaList = [];
    (state.details.media ?? []).map((e) => mediaList.add(Right(e))).toList();
    titleController.text = state.details.title ?? "";
    descriptionController.text = state.details.shortDescription ?? "";
    setData(context);
  }
}
