import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';

import '../constants/colors_constants.dart';
import 'app.dart';




class Picker {
  static Future<void> showImagePicker(context, Function(XFile?) onTap,
      {required double x, required double y}) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo_library,color: Theme.of(context).colorScheme.tertiaryContainer),
                    title: const SimpleText(text: 'Library'),
                    onTap: () async {
                      onTap(await _imgFromGallery(context,x, y));
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera,color: Theme.of(context).colorScheme.tertiaryContainer),
                  title: const SimpleText(text:'Camera'),
                  onTap: () async {
                    onTap(await _imgFromCamera(context,x, y));
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  static Future<XFile?> _imgFromCamera(BuildContext context,double x, double y) async {
    XFile? selectedImages =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (selectedImages != null) {
      try{

        if(await AppHelper.checkFileSize(File(selectedImages.path))){
          CroppedFile? croppedFile = await ImageCropper().cropImage(
            sourcePath: selectedImages.path,
            aspectRatio: CropAspectRatio(ratioX: x, ratioY: y),
              // androidUiSettings:   AndroidUiSettings(
              //     toolbarTitle: 'Crop Image',
              //     toolbarColor: ColorsConstants.appColor,
              //     toolbarWidgetColor: ColorsConstants.white,
              //     initAspectRatio: CropAspectRatioPreset.original,
              //     lockAspectRatio: false) ,
              // iosUiSettings: const IOSUiSettings(
              //   title: 'Crop Image',
              // )
          );
          if (croppedFile != null) {
            return XFile(croppedFile.path);
          } else {
            return null;
          }
        }else{
          if(context.mounted){
            Future.delayed(const Duration(microseconds: 500)).then((value) {
              AppHelper.fileExceedSizeError(context, AppHelper.fileSizeError());
            });
          }
        }


      }catch(e){
        AppHelper.myPrint("------------------ Exception in Image Cropper ---------------------");
        AppHelper.myPrint(e);
        AppHelper.myPrint("---------------------------------------");
        if(context.mounted){
          AppHelper.showSnakeBar(
              context,e.toString());
        }
      }

    }
    return null;
  }

  static Future<XFile?> _imgFromGallery(BuildContext context,double x, double y) async {
    XFile? selectedImages =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImages != null) {
      try{
        if(await AppHelper.checkFileSize(File(selectedImages.path))){
          CroppedFile? croppedFile = await ImageCropper().cropImage(
            sourcePath: selectedImages.path,
            aspectRatio: CropAspectRatio(ratioX: x, ratioY: y),
              // androidUiSettings:   AndroidUiSettings(
              //     toolbarTitle: 'Crop Image',
              //     toolbarColor: ColorsConstants.appColor,
              //     toolbarWidgetColor: ColorsConstants.white,
              //     initAspectRatio: CropAspectRatioPreset.original,
              //     lockAspectRatio: false) ,
              // iosUiSettings: const IOSUiSettings(
              //   title: 'Crop Image',
              // )
          );
          if (croppedFile != null) {
            return XFile(croppedFile.path);
          } else {
            return null;
          }
        }else{
          if(context.mounted){
            Future.delayed(const Duration(microseconds: 500)).then((value) {
              AppHelper.fileExceedSizeError(context, AppHelper.fileSizeError());

            });
          }
        }
      }catch(e){
        AppHelper.myPrint("------------------ Exception in Image Cropper ---------------------");
        AppHelper.myPrint(e);
        AppHelper.myPrint("---------------------------------------");
        if(context.mounted){
          AppHelper.showSnakeBar(
              context,e.toString());
        }
      }
    }
    return null;
  }

  static Future<void> showVideoPicker(context, Function(XFile?) onTap) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading:  Icon(Icons.photo_library,color: Theme.of(context).colorScheme.tertiaryContainer),
                    title: const SimpleText(text:'Library'),
                    onTap: () async {
                      onTap(await _videoFromGallery(context));
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading:  Icon(Icons.photo_camera,color: Theme.of(context).colorScheme.tertiaryContainer),
                  title: const SimpleText(text:'Camera'),
                  onTap: () async {
                    onTap(await _videoFromCamera(context));
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  static Future<XFile?> _videoFromCamera(BuildContext context) async {

    XFile? file = await ImagePicker().pickVideo(
        source: ImageSource.camera, maxDuration: const Duration(minutes: 1));

    if(file != null){
      if(await AppHelper.checkFileSize(File(file.path))){
        return file;
      }else{
        if(context.mounted){
          Future.delayed(const Duration(microseconds: 500)).then((value) {
            AppHelper.fileExceedSizeError(context, AppHelper.fileSizeError());
          });
        }
      }
    }
    return null ;
  }

  static Future<XFile?> _videoFromGallery(BuildContext context) async {

    XFile? file = await ImagePicker().pickVideo(
        source: ImageSource.gallery, maxDuration: const Duration(minutes: 1));

    if(file != null){
      if(await AppHelper.checkFileSize(File(file.path))){
        return file;
      }else{
        if(context.mounted){
          Future.delayed(const Duration(microseconds: 500)).then((value) {
            AppHelper.fileExceedSizeError(context, AppHelper.fileSizeError());

          });
        }
      }
    }
    return null ;

  }
}
