import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:refcue_app/shared/const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:image_cropper/image_cropper.dart';

part 'profile_picture_state.dart';

class ProfilePictureCubit extends Cubit<ProfilePictureState> {
  ProfilePictureCubit(this.user) : super(ProfilePictureInitial());

  final _picker = ImagePicker();
  final user;
  final authUser = auth.FirebaseAuth.instance.currentUser;

  //Take image from user's camera
  Future getImageFromUser(ImageSource userChoiceSource) async {
    PickedFile imagePickedBefore;
    if (state is ProfilePictureSuccess) {
      imagePickedBefore = (state as ProfilePictureSuccess).image;
    }
    emit(ProfilePictureLoading());
    try {
      PickedFile image = await _picker.getImage(source: userChoiceSource);
      if (image != null) {
        emit(ProfilePictureSuccess(image: image));
      } else {
        emit(ProfilePictureInitial());
      }
    } catch (error) {
      if (imagePickedBefore != null) {
        emit(ProfilePictureSuccess(image: imagePickedBefore));
      } else {
        emit(ProfilePictureInitial());
      }
      throw (error);
    }
  }

  Future cropImage(context) async {
    if (state is ProfilePictureSuccess) {
      var image = (state as ProfilePictureSuccess).image;
      emit(ProfilePictureLoading());
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          cropStyle: CropStyle.circle,
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Przytnij swoje zdjęcie',
              hideBottomControls: true,
              showCropGrid: true,
              backgroundColor: Theme.of(context).backgroundColor,
              toolbarColor: kAccentColor,
              toolbarWidgetColor: Colors.black,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            title: 'Przytnij swoje zdjęcie',
          ));

      if (cropped != null) {
        emit(ProfilePictureCropped(croppedImage: cropped));
      } else {
        emit(ProfilePictureInitial());
      }
    }
  }

  //Upload file to firebase and then swap with acount's profile picture
  Future uploadFile() async {
    if (state is ProfilePictureSuccess || state is ProfilePictureCropped) {
      File image;
      if (state is ProfilePictureCropped) {
        image = (state as ProfilePictureCropped).croppedImage;
      }
      if (state is ProfilePictureSuccess) {
        image = File((state as ProfilePictureSuccess).image.path);
      }
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child('/${user.id}');
      try {
        emit(ProfilePictureLoading());
        await storageReference.putFile(image).then((snapshot) =>
            storageReference.getDownloadURL().then((fileURL) async {
              emit(ProfilePictureSent(imageURL: fileURL));
              print('File Uploaded');
              await Future.delayed(Duration(seconds: 1));
              print(fileURL.toString());
              try {
                authUser.updateProfile(photoURL: fileURL);
              } catch (error) {
                emit(ProfilePictureSentError());
                throw (error);
              }
            }));
      } catch (error) {
        emit(ProfilePictureSentError());
        throw (error);
      }
    }
  }
}
