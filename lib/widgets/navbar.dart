import 'package:flutter/material.dart';

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
      backgroundColor: const Color(0xff3f51b5),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      iconSize: 40,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map')
      ],
      currentIndex: currentIndex,
      onTap: _onItemTapped,
    );
  }
}
