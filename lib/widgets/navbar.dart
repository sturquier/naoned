import 'package:flutter/material.dart';
import 'package:naoned/config/theme.dart';

class Navbar extends StatelessWidget {
  const Navbar(
      {Key? key,
      required this.currentIndex,
      required this.setCurrentIndexCallback})
      : super(key: key);

  final int currentIndex;
  final void Function(dynamic index) setCurrentIndexCallback;

  void _onItemTapped(int index) {
    setCurrentIndexCallback(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: theme['cyan900'],
      unselectedItemColor: theme['cyan200'],
      selectedItemColor: theme['white'],
      iconSize: 30,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.perm_contact_calendar), label: 'Calendar'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map')
      ],
      currentIndex: currentIndex,
      onTap: _onItemTapped,
    );
  }
}
