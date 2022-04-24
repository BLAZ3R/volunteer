import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/constants/MainTheme.dart';
import 'package:volunteer/screens/profileScreen.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({Key? key, required this.initialPage}) : super(key: key);

  final String initialPage;

  @override
  _NavBarScreenState createState() => _NavBarScreenState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarScreenState extends State<NavBarScreen> {
  String _currentPage = 'HomePage';

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'HomeScreen': Container(),
      'CreateScreen': Container(),
      'ProfileScreen': ProfileScreen(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPage);
    return Scaffold(
      body: tabs[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => _currentPage = tabs.keys.toList()[i]),
        backgroundColor: Colors.white,
        selectedItemColor: MainTheme.of(context).primaryColor,
        unselectedItemColor: Color(0x8A000000),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              size: 24,
            ),
            label: 'Главная',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map,
              size: 24,
            ),
            label: 'Карта',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 24,
            ),
            label: 'Профиль',
            tooltip: '',
          ),
        ],
      ),
    );
  }
}
