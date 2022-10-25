import 'package:flutter/material.dart';
import 'package:naoned/config/theme.dart';

class NavbarWidget extends StatelessWidget {
  final int currentIndex;
  final void Function(int index) setCurrentIndexCallback;

  const NavbarWidget(
      {Key? key,
      required this.currentIndex,
      required this.setCurrentIndexCallback})
      : super(key: key);

  void _onItemTapped(int index) {
    setCurrentIndexCallback(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: theme['cyan600'],
      unselectedItemColor: theme['cyan200'],
      selectedItemColor: theme['white'],
      iconSize: 30,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Calendar'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map')
      ],
      currentIndex: currentIndex,
      onTap: _onItemTapped,
    );
  }
}
