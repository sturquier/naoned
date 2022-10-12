import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:naoned/config/theme.dart';

enum LoaderSize { small, big }

Widget _getDiscreteCircle({double size = 60}) {
  return LoadingAnimationWidget.discreteCircle(
      size: size,
      color: theme['cyan800']!,
      secondRingColor: theme['cyan500']!,
      thirdRingColor: theme['cyan200']!);
}

Widget getLoader({LoaderSize size = LoaderSize.big}) {
  if (size == LoaderSize.big) {
    return _getDiscreteCircle();
  }

  return _getDiscreteCircle(size: 20);
}
