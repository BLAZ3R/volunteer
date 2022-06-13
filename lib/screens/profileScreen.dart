import 'dart:convert';
import 'dart:typed_data';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:image_picker/image_picker.dart';
import 'package:volunteer/constants/MainTheme.dart';
import 'package:volunteer/data/api/UserApi.dart';
import 'package:volunteer/data/models/Volunteer.dart';
import 'package:volunteer/data/storage/user_secure_storage.dart';
import 'package:volunteer/data/storage/user_shared_preferences.dart';
import 'package:volunteer/logic/blocs/user/user_bloc.dart';
import 'package:volunteer/logic/blocs/user/user_event.dart';
import 'package:volunteer/screens/authScreen.dart';
import 'package:volunteer/screens/editProfileScreen.dart';
import 'package:volunteer/screens/loginScreen.dart';

import '../data/models/User.dart';
import '../logic/blocs/user/user_state.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(
          UserFetched(),
        );
    return Scaffold(
        body: SafeArea(
      child:
          (Padding(padding: const EdgeInsets.all(20.0), child: _profileForm())),
    ));
  }

  Widget _profileForm() {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      Volunteer? user;
      Uint8List? myImage;
      if (state is UserLoadFailure) {
        return InkWell(
            onTap: () async {
              UserSharedPreferences.deleteEmail();
              Phoenix.rebirth(context);

              // await Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => LoginView(),
              //   ),
              //   (r) => false,
              // );
            },
            child: Column(
              children: [Text(state.errorMessage), Text("error")],
            ));
      }
      if (state is UsersLoadInProgress) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state is UserLoadSuccess) {
        print("yelded");
        user = state.user;
        // if (user.image != null) {
        //   // final UriData? data = Uri.parse(user.image).data;
        //   // myImage = data?.contentAsBytes();
        // }
      }

      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 120,
            height: 120,
            child: Stack(
              children: [
                if (myImage != null)
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: Image.memory(
                        myImage!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                if (myImage == null)
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: Image.asset(
                        "asset/image/unknown.png",
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                // Align(
                //   alignment: AlignmentDirectional(0.3, 1),
                //   child: InkWell(
                //     onTap: () async {
                //       final ImagePicker _picker = ImagePicker();
                //       final XFile? image =
                //           await _picker.pickImage(source: ImageSource.gallery);
                //       if (image != null) {
                //         print("image");
                //         List<int>? imageBytes = await image?.readAsBytes();
                //         String base64 = base64Encode(imageBytes!);
                //         print(base64);
                //         bool val = await UserApi().changePhoto(base64);
                //         if (val) {
                //           context.read<UserBloc>().add(
                //                 UserFetched(),
                //               );
                //         }
                //       }
                //     },
                //     child: Container(
                //       width: 35,
                //       height: 35,
                //       clipBehavior: Clip.antiAlias,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(8),
                //         color: MainTheme.of(context).primaryColor,
                //       ),
                //       child: Icon(
                //         Icons.photo_camera_outlined,
                //         color: Colors.white,
                //         size: 25,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(13, 24, 13, 0),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Тип: ',
                          style: MainTheme.of(context).bodyText1,
                        ),
                        Text(
                          user!.roles.first.roleName == "VOLUNTEER"
                              ? "Волонтер"
                              : "Организация",
                          style: MainTheme.of(context).bodyText1,
                        ),
                      ],
                    ),
                    Divider(
                      height: 24,
                      thickness: 0.2,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Полное имя: ',
                          style: MainTheme.of(context).bodyText1,
                        ),
                        Text(
                          user?.firstName ?? "Не загружено",
                          style: MainTheme.of(context).bodyText1,
                        ),
                      ],
                    ),
                    if (user!.roles.first.roleName == "ORGANIZER")
                      Divider(
                        height: 24,
                        thickness: 0.2,
                        color: Colors.black,
                      ),
                    if (user!.roles.first.roleName == "ORGANIZER")
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Название организации: ${user.organizationName} ',
                            style: MainTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    Divider(
                      height: 24,
                      thickness: 0.2,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Почта: ',
                          style: MainTheme.of(context).bodyText1,
                        ),
                        Text(
                          user?.email ?? "Не загружено",
                          style: MainTheme.of(context).bodyText1,
                        ),
                      ],
                    ),
                    Divider(
                      height: 24,
                      thickness: 0.2,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Номер телефона: ',
                          style: MainTheme.of(context).bodyText1,
                        ),
                        Text(
                          user?.phoneNumber ?? "Не загружено",
                          style: MainTheme.of(context).bodyText1,
                        ),
                      ],
                    ),
                    Divider(
                      height: 24,
                      thickness: 0.2,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Дата рождения: ',
                          style: MainTheme.of(context).bodyText1,
                        ),
                        Text(
                          user?.dateOfBirthday ?? "Не загружено",

                          // formatDate(DateTime(2003, 01, 26),
                          //     [yyyy, '-', mm, '-', dd]),
                          style: MainTheme.of(context).bodyText1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(13, 24, 13, 0),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                      onTap: () async {
                        // await Share.share('URL to download');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    EditProfileScreen(volunteer: user)));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 26, 0),
                            child: Icon(
                              Icons.edit,
                              color: MainTheme.of(context).primaryColor,
                              size: 24,
                            ),
                          ),
                          Text(
                            'Изменить профиль',
                            style: MainTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24,
                      thickness: 0.2,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 26, 0),
                          child: Icon(
                            Icons.file_copy_outlined,
                            color: MainTheme.of(context).primaryColor,
                            size: 24,
                          ),
                        ),
                        Text('Правила и политика',
                            style: MainTheme.of(context).bodyText1),
                      ],
                    ),
                    Divider(
                      height: 24,
                      thickness: 0.2,
                      color: Colors.black,
                    ),
                    InkWell(
                      onTap: () async {
                        // await signOut();
                        await UserSecureStorage.deleteToken();
                        UserSharedPreferences.deleteEmail();

                        Phoenix.rebirth(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 26, 0),
                            child: Icon(
                              Icons.logout,
                              color: MainTheme.of(context).primaryColor,
                              size: 24,
                            ),
                          ),
                          Text('Выйти', style: MainTheme.of(context).bodyText1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
