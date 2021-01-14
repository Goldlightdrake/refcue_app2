part of 'profile_picture_cubit.dart';

abstract class ProfilePictureState extends Equatable {
  const ProfilePictureState();

  @override
  List<Object> get props => [];
}

class ProfilePictureInitial extends ProfilePictureState {}

class ProfilePictureLoading extends ProfilePictureState {}

class ProfilePictureSuccess extends ProfilePictureState {
  final PickedFile image;
  ProfilePictureSuccess({
    this.image,
  });

  @override
  List<Object> get props => [image];

  @override
  String toString() => 'ProfilePictureSuccess(image: $image)';
}

class ProfilePictureSent extends ProfilePictureState {
  final String imageURL;
  ProfilePictureSent({
    this.imageURL,
  });

  @override
  List<Object> get props => [imageURL];

  @override
  String toString() => 'ProfilePictureSent(imageURL: $imageURL)';
}

class ProfilePictureSentError extends ProfilePictureSent {}
