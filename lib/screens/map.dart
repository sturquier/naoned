import 'package:flutter/material.dart';

class Map extends StatelessWidget {
  const Map({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text('Map', style: Theme.of(context).textTheme.headline1)));
  }
}
