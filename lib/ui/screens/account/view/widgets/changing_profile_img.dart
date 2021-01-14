import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/firebase_login/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_firebase_login/logic/account_logic/cubit/profile_picture_cubit.dart';
import 'package:flutter_firebase_login/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ChangingProfileImage extends StatelessWidget {
  const ChangingProfileImage({
    Key key,
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
              BlocBuilder<ProfilePictureCubit, ProfilePictureState>(
                builder: (context, state) {
                  if (state is ProfilePictureSentError) {
                    return Text(
                        'Coś poszło nie tak, spróbuj zresetować aplikacje',
                        style: kTitleTextStyle);
                  }
                  if (state is ProfilePictureSuccess) {
                    return CircleAvatar(
                        radius: kSpacingUnit.w * 10,
                        backgroundImage: AssetImage(state.image.path));
                  }
                  if (state is ProfilePictureLoading) {
                    return CircularProgressIndicator();
                  }
                  return CircleAvatar(
                      radius: kSpacingUnit.w * 8,
                      backgroundImage: NetworkImage(user.photo));
                },
              ),
              SizedBox(height: kSpacingUnit.w * 4),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                          onPressed: () => context
                              .read<ProfilePictureCubit>()
                              .getImageFromUser(),
                          textColor: Colors.black,
                          child: Icon(Icons.edit),
                          color: Theme.of(context).accentColor),
                      SizedBox(
                        width: kSpacingUnit.w * 2,
                      ),
                      FlatButton(
                          onPressed: () =>
                              context.read<ProfilePictureCubit>().uploadFile(),
                          textColor: Colors.black,
                          child: Icon(Icons.check),
                          color: Theme.of(context).accentColor),
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
