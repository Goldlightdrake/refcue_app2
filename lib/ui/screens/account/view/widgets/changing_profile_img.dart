import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refcue_app/logic/account_logic/profile_picture_cubit/profile_picture_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:refcue_app/firebase_login/authentication/bloc/authentication_bloc.dart';

import 'package:refcue_app/shared/const.dart';

class ChangingProfileImage extends StatelessWidget {
  const ChangingProfileImage({
    Key? key,
  }) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ChangingProfileImage());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    var header = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: kSpacingUnit.w * 3),
          IconButton(
            onPressed: () => Navigator.of(context).pop<void>(),
            icon: Icon(LineAwesomeIcons.arrow_left),
            iconSize: ScreenUtil().setSp(kSpacingUnit.w * 3),
          ),
        ]);

    return BlocProvider(
      create: (context) => ProfilePictureCubit(user),
      child: Builder(
        builder: (context) => Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: kSpacingUnit.w * 5),
                  header,
                ],
              ),
              BlocConsumer<ProfilePictureCubit, ProfilePictureState>(
                listener: (context, state) {
                  if (state is ProfilePictureSuccess) {
                    context.read<ProfilePictureCubit>().cropImage(context);
                  }
                },
                builder: (context, state) {
                  if (state is ProfilePictureSentError) {
                    return Text(
                        'Coś poszło nie tak, spróbuj zresetować aplikacje',
                        style: kTitleTextStyle);
                  }
                  if (state is ProfilePictureSent) {
                    return Container(
                      width: kSpacingUnit.w * 15,
                      height: kSpacingUnit.w * 15,
                      child: FlareActor(
                        doneAnimation,
                        animation: 'done',
                      ),
                    );
                  }

                  if (state is ProfilePictureCropped) {
                    return CircleAvatar(
                        radius: kSpacingUnit.w * 10,
                        backgroundImage: FileImage(state.croppedImage!));
                  }
                  if (state is ProfilePictureLoading) {
                    return CircularProgressIndicator();
                  }

                  return Hero(
                      tag: 'avatar',
                      child: Builder(
                          builder: (context) => user.photo != null
                              ? CachedNetworkImage(
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  imageUrl: (user.photo)!,
                                  imageBuilder: (context, imageProvider) {
                                    return CircleAvatar(
                                      radius: kSpacingUnit.w * 10,
                                      backgroundImage: imageProvider,
                                    );
                                  },
                                )
                              : CircleAvatar(
                                  radius: kSpacingUnit.w * 10,
                                  backgroundImage: AssetImage(basicAvatarImage),
                                )));
                },
              ),
              SizedBox(height: kSpacingUnit.w * 4),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => SimpleDialog(
                            backgroundColor: Theme.of(context).cardColor,
                            title: Text("Wybierz źródło zdjęcia",
                                style: kTitleTextStyle.copyWith(
                                    fontSize: kSpacingUnit.w * 2,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color)),
                            elevation: 24.0,
                            children: [
                              SimpleDialogOption(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                onPressed: () {
                                  context
                                      .read<ProfilePictureCubit>()
                                      .getImageFromUser(ImageSource.camera);
                                  Navigator.pop(_);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.camera_alt,
                                        color:
                                            Theme.of(context).iconTheme.color),
                                    SizedBox(width: kSpacingUnit.w * 1.5),
                                    Text('Zrób zdjęcie',
                                        style: kTitleTextStyle.copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color))
                                  ],
                                ),
                              ),
                              SimpleDialogOption(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                onPressed: () {
                                  context
                                      .read<ProfilePictureCubit>()
                                      .getImageFromUser(ImageSource.gallery);
                                  Navigator.pop(_);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.photo,
                                        color:
                                            Theme.of(context).iconTheme.color),
                                    SizedBox(width: kSpacingUnit.w * 1.5),
                                    Text('Wybierz z galerii',
                                        style: kTitleTextStyle.copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            onPrimary: Colors.black, primary: kAccentColor),
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Icon(Icons.edit)),
                      ),
                      SizedBox(
                        width: kSpacingUnit.w * 2,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<ProfilePictureCubit>().uploadFile();
                        },
                        style: ElevatedButton.styleFrom(
                            onPrimary: Colors.black, primary: kAccentColor),
                        child: Padding(
                          child: Icon(Icons.check, size: kSpacingUnit.w * 3.5),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: kSpacingUnit.w * 6),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
