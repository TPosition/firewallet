import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_login/app/app.dart';
import 'package:flutter_firebase_login/auth_select/auth_select.dart';
import 'package:flutter_firebase_login/home/home.dart';
import 'package:google_fonts/google_fonts.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [BottomNavBar.page()];
    case AppStatus.unauthenticated:
    default:
      return [AuthSelect.page()];
  }
}

class BottomNavBar extends StatefulWidget {
  static Page page() => const MaterialPage<void>(child: BottomNavBar());
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final TextStyle _optionStyle = GoogleFonts.roboto(
      color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14);
  final List<Widget> _widgetOptions = [
    const HomePage(),
    const HomePage(),
    const HomePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? Image.asset('assets/ico_home_selected.png')
                : Image.asset('assets/ico_home.png'),
            title: Text(
              'Home',
              style: _optionStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Image.asset('assets/ico_history_selected.png')
                : Image.asset('assets/ico_history.png'),
            title: Text(
              'History',
              style: _optionStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? Image.asset('assets/ico_profile_selected.png')
                : Image.asset('assets/ico_profile.png'),
            title: Text(
              'Profile',
              style: _optionStyle,
            ),
          ),
        ],
      ),
    );
  }
}
