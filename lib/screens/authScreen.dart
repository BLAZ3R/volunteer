import 'package:flutter/material.dart';
import 'package:volunteer/constants/MainTheme.dart';
import 'package:volunteer/screens/signUpScreen.dart';

import '../components/RoundedButton.dart';
import '../components/RoundedInputField.dart';
import '../components/RoundedPasswordField.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _index = 0;
  late TextEditingController textController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: size.width,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      setState(() {
                        _index = 0;
                      });
                    },
                    child: Container(
                      width:
                          _index == 0 ? size.width * 0.45 : size.width * 0.43,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _index == 0 ? Colors.white : Colors.grey,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text('Волонтер',
                            textAlign: TextAlign.center,
                            style: MainTheme.of(context).bodyText1),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        _index = 1;
                      });
                    },
                    child: Container(
                      width:
                          _index == 1 ? size.width * 0.45 : size.width * 0.43,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _index == 1 ? Colors.white : Colors.grey,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text('Организация',
                            textAlign: TextAlign.center,
                            style: MainTheme.of(context).bodyText1),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Почта",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "ВОЙТИ",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  child: Text(
                    "Создать аккаунт",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
