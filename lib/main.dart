import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer/data/api/AuthApi.dart';
import 'package:volunteer/data/api/UserApi.dart';
import 'package:volunteer/data/storage/user_secure_storage.dart';
import 'package:volunteer/logic/blocs/auth/login/login_bloc.dart';
import 'package:volunteer/logic/blocs/user/user_bloc.dart';
import 'package:volunteer/screens/loginScreen.dart';
import 'package:volunteer/screens/authScreen.dart';
import 'package:volunteer/screens/navbarScreen.dart';
import 'package:volunteer/screens/profileScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volunteer',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<AuthApi>(
              create: (context) => AuthApi(),
            ),
            RepositoryProvider<UserApi>(
              create: (context) => UserApi(),
            ),
            // RepositoryProvider<RepositoryC>(
            //   create: (context) => RepositoryC(),
            // ),
          ],
          child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      LoginBloc(authRepo: context.read<AuthApi>()),
                ),
                BlocProvider(
                  create: (context) =>
                      UserBloc(userApi: context.read<UserApi>()),
                ),
              ],
              child: UserSecureStorage.containsToken() == "false"
                  ? LoginView()
                  : NavBarScreen(initialPage: "ProfileScreen"))),
    );
  }

  Future<bool> isLogged() async {
    String? token = await UserSecureStorage.getToken();
    return token == null ? false : true;
  }
}
