import 'package:flutter/material.dart';

class MotionConstants {
  // Material motion standard durations
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 400);
  static const Duration slow = Duration(milliseconds: 500);
  
  // Material motion standard curves
  static const Curve standardEasing = Curves.fastOutSlowIn;
  static const Curve emphasizedEasing = Curves.easeInOut;
  static const Curve deceleratedEasing = Curves.easeOut;
  static const Curve acceleratedEasing = Curves.easeIn;
  
  // Animation configuration
  static const Duration pageTransition = medium;
  static const Duration contentTransition = fast;
  static const Duration modalTransition = slow;
}