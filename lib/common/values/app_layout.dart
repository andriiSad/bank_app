import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLayout {
  static Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getScreenHeight() {
    return Get.height;
  }

  static double getScreenWidth() {
    return Get.width;
  }

// TODO: fix this
  static double getHeight(double pixels) {
    final double x = getScreenHeight() / pixels;
    return getScreenHeight() / x;
  }

// TODO: fix this
  static double getWidth(double pixels) {
    final double x = getScreenWidth() / pixels;
    return getScreenWidth() / x;
  }
}
