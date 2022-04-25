import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/constants/MainTheme.dart';
import 'package:volunteer/screens/login_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: (Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                            "Волонтер",
                            style: MainTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                      Divider(
                        height: 24,
                        thickness: 0.5,
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
                            "Amir Tleuzhan",
                            style: MainTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                      Divider(
                        height: 24,
                        thickness: 0.5,
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
                            "amirplay0@gmail.com",
                            style: MainTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                      Divider(
                        height: 24,
                        thickness: 0.5,
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
                            "+ 7 (700) 000 08 36",
                            style: MainTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                      Divider(
                        height: 24,
                        thickness: 0.5,
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
                            formatDate(DateTime(2003, 01, 26),
                                [yyyy, '-', mm, '-', dd]),
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
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 26, 0),
                              child: Icon(
                                Icons.offline_share,
                                color: MainTheme.of(context).primaryColor,
                                size: 24,
                              ),
                            ),
                            Text(
                              'FAQ',
                              style: MainTheme.of(context).bodyText1,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 24,
                        thickness: 0.5,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 26, 0),
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
                        thickness: 0.5,
                        color: Colors.black,
                      ),
                      InkWell(
                        onTap: () async {
                          // await signOut();
                          await Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginView(),
                            ),
                            (r) => false,
                          );
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
                            Text('Выйти',
                                style: MainTheme.of(context).bodyText1),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ))),
    );
  }
}
