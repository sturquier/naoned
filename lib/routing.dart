import 'package:flutter/material.dart';
import 'package:naoned/screens/calendar.dart';
import 'package:naoned/screens/home.dart';
import 'package:naoned/screens/map.dart';
import 'package:naoned/widgets/navbar.dart';

class Routing extends StatefulWidget {
  const Routing({Key? key}) : super(key: key);

  @override
  State<Routing> createState() => _RoutingState();
}

class _RoutingState extends State<Routing> {
  int currentIndex = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const CalendarScreen(),
    const MapScreen()
  ];

  void _setCurrentIndex(int index) {
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: NavbarWidget(
          currentIndex: currentIndex,
          setCurrentIndexCallback: (int index) => _setCurrentIndex(index)),
    );
  }
}
