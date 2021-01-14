import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'profile_picture_state.dart';

class ProfilePictureCubit extends Cubit<ProfilePictureState> {
  ProfilePictureCubit(this.user) : super(ProfilePictureInitial());

  final _picker = ImagePicker();
  final user;
  final auth_user = auth.FirebaseAuth.instance.currentUser;

  Future getImageFromUser() async {
    PickedFile imagePickedBefore;
    if (state is ProfilePictureSuccess) {
      imagePickedBefore = (state as ProfilePictureSuccess).image;
    }
    emit(ProfilePictureLoading());
    try {
      PickedFile image = await _picker.getImage(source: ImageSource.camera);
      if (image != null) {
        emit(ProfilePictureSuccess(image: image));
      } else {
        throw ('Image is an null');
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

  Future uploadFile() async {
    if (state is ProfilePictureSuccess) {
      final image = File((state as ProfilePictureSuccess).image.path);
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child('/${user.id}');
      try {
        await storageReference.putFile(image).then(
            (snapshot) => storageReference.getDownloadURL().then((fileURL) {
                  emit(ProfilePictureSent(imageURL: fileURL));
                  print('File Uploaded');
                  print(fileURL.toString());
                  try {
                    auth_user.updateProfile(photoURL: fileURL);
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
