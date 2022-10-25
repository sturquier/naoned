import 'package:flutter/material.dart';

Map<String, Color> _basic = {
  'black': const Color(0x00000000),
  'white': const Color(0xffffffff),
};

Map<String, Color> _cyan = {
  'cyan50': const Color(0xffe8eaf6),
  'cyan100': const Color(0xffc5cae9),
  'cyan200': const Color(0xff9fa8da),
  'cyan300': const Color(0xff7986cb),
  'cyan400': const Color(0xff5c6bc0),
  'cyan500': const Color(0xff3f51b5),
  'cyan600': const Color(0xff3949ab),
  'cyan700': const Color(0xff303f9f),
  'cyan800': const Color(0xff283593),
  'cyan900': const Color(0xff1a237e)
};

Map<String, Color> _red = {
  'red50': const Color(0xffffebee),
  'red100': const Color(0xffffcdd2),
  'red200': const Color(0xffef9a9a),
  'red300': const Color(0xffe57373),
  'red400': const Color(0xffef5350),
  'red500': const Color(0xfff44336),
  'red600': const Color(0xffe53935),
  'red700': const Color(0xffd32f2f),
  'red800': const Color(0xffc62828),
  'red900': const Color(0xffb71c1c)
};

Map<String, Color> theme = {
  ..._basic,
  ..._cyan,
  ..._red,
};
