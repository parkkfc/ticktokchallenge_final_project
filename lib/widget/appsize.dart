import 'package:flutter/material.dart';

class AppSize {
  // --- Spacing (여백) ---
  static const double s2 = 2.0;
  static const double s4 = 4.0;
  static const double s8 = 8.0; // 기본 최소 단위
  static const double s12 = 12.0; // 포스트 내부 여백
  static const double s16 = 16.0; // 가장 많이 쓰이는 사이드 여백
  static const double s24 = 24.0;
  static const double s32 = 32.0;

  // --- Vertical Spacing (SizedBox) ---
  static const h4 = SizedBox(height: s4);
  static const h8 = SizedBox(height: s8);
  static const h12 = SizedBox(height: s12);
  static const h16 = SizedBox(height: s16);
  static const h24 = SizedBox(height: s24);

  // --- Horizontal Spacing (SizedBox) ---
  static const w4 = SizedBox(width: s4);
  static const w8 = SizedBox(width: s8);
  static const w12 = SizedBox(width: s12);
  static const w16 = SizedBox(width: s16);
}
