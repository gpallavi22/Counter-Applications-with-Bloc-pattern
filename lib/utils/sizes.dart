import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Sizes {
  Sizes();

  static bool get isTablet => SizerUtil.deviceType == DeviceType.tablet;

  // ---------- BASE HELPERS ----------

  static double w(double percent, {double? max}) {
    final value = percent.w;
    return (isTablet && max != null) ? min(value, max) : value;
  }

  static double h(double percent, {double? max}) {
    final value = percent.h;
    return (isTablet && max != null) ? min(value, max) : value;
  }

  // ---------- SPACING ----------

  static double get space => w(4, max: 24);
  static double get sectionSpace => w(6, max: 32);

  // ---------- TEXT ----------

  static double text(double mobile, {double? tablet}) {
    return isTablet ? (tablet ?? mobile) : mobile;
  }

  static double get h1 => text(35, tablet: 14);
  static double get h2 => text(16, tablet: 12);
  static double get body => text(14, tablet: 11);
  static double get small => text(12, tablet: 10);

  // ---------- ICON ----------

  static double icon(double mobile, {double? tablet}) {
    return isTablet ? (tablet ?? mobile) : mobile;
  }

  static double get iconMd => icon(24, tablet: 20);

  // ---------- PADDING ----------

  static EdgeInsets get padding => EdgeInsets.all(w(4, max: 24));

  static EdgeInsets get paddingH => EdgeInsets.symmetric(horizontal: w(5, max: 28));

  static EdgeInsets get paddingV => EdgeInsets.symmetric(vertical: h(2, max: 20));
}
