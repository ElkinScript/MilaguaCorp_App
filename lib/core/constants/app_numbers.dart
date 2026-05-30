import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Separadores (Gap / spacing)
// ─────────────────────────────────────────────────────────────────────────────
const double separatorNone = 0;
const double separatorXs = 4.0;
const double separatorSm = 8.0;
const double separatorMd = 16.0;
const double separatorLg = 24.0;
const double separatorXl = 32.0;
const double separatorXxl = 48.0;

// ─────────────────────────────────────────────────────────────────────────────
// Radios de borde
// ─────────────────────────────────────────────────────────────────────────────
const double kRadiusNone = 0;
const double kRadiusXs = 4.0;
const double kRadiusSm = 8.0;
const double kRadiusMd = 12.0;
const double kRadiusLg = 16.0;
const double kRadiusXl = 20.0;
const double kRadiusCircular = 100.0;

// ─────────────────────────────────────────────────────────────────────────────
// Tamaños de pantalla (breakpoints)
// ─────────────────────────────────────────────────────────────────────────────
const double kDeviceSm = 360.0;
const double kDeviceMd = 480.0;
const double kDeviceTablet = 600.0;
const double kDeviceDesktop = 1024.0;

// ─────────────────────────────────────────────────────────────────────────────
// Padding uniformes — kSpaceDevice + [dirección] + [tamaño]
// Uso: Padding(padding: kSpaceDeviceLg)
// ─────────────────────────────────────────────────────────────────────────────
const EdgeInsets kSpaceDeviceNone = EdgeInsets.all(0);
const EdgeInsets kSpaceDeviceXs   = EdgeInsets.all(4);
const EdgeInsets kSpaceDeviceSm   = EdgeInsets.all(8);
const EdgeInsets kSpaceDeviceMd   = EdgeInsets.all(16);
const EdgeInsets kSpaceDeviceLg   = EdgeInsets.all(24);
const EdgeInsets kSpaceDeviceXl   = EdgeInsets.all(32);

// Horizontal
const EdgeInsets kSpaceDeviceHXs  = EdgeInsets.symmetric(horizontal: 4);
const EdgeInsets kSpaceDeviceHSm  = EdgeInsets.symmetric(horizontal: 8);
const EdgeInsets kSpaceDeviceHMd  = EdgeInsets.symmetric(horizontal: 16);
const EdgeInsets kSpaceDeviceHLg  = EdgeInsets.symmetric(horizontal: 24);

// Vertical
const EdgeInsets kSpaceDeviceVXs  = EdgeInsets.symmetric(vertical: 4);
const EdgeInsets kSpaceDeviceVSm  = EdgeInsets.symmetric(vertical: 8);
const EdgeInsets kSpaceDeviceVMd  = EdgeInsets.symmetric(vertical: 16);
const EdgeInsets kSpaceDeviceVLg  = EdgeInsets.symmetric(vertical: 24);

// Horizontal + Vertical combinados
const EdgeInsets kSpaceDeviceHVSm  = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
const EdgeInsets kSpaceDeviceHVMd  = EdgeInsets.symmetric(horizontal: 16, vertical: 16);
const EdgeInsets kSpaceDeviceHVLg  = EdgeInsets.symmetric(horizontal: 24, vertical: 16);

// Top
const EdgeInsets kSpaceDeviceTSm  = EdgeInsets.only(top: 8);
const EdgeInsets kSpaceDeviceTMd  = EdgeInsets.only(top: 16);
const EdgeInsets kSpaceDeviceTLg  = EdgeInsets.only(top: 24);

// Bottom
const EdgeInsets kSpaceDeviceBSm  = EdgeInsets.only(bottom: 8);
const EdgeInsets kSpaceDeviceBMd  = EdgeInsets.only(bottom: 16);
const EdgeInsets kSpaceDeviceBLg  = EdgeInsets.only(bottom: 24);

// Left
const EdgeInsets kSpaceDeviceLSm  = EdgeInsets.only(left: 8);
const EdgeInsets kSpaceDeviceLMd  = EdgeInsets.only(left: 16);

// Right
const EdgeInsets kSpaceDeviceRSm  = EdgeInsets.only(right: 8);
const EdgeInsets kSpaceDeviceRMd  = EdgeInsets.only(right: 16);

// ─────────────────────────────────────────────────────────────────────────────
// BorderRadius presets
// ─────────────────────────────────────────────────────────────────────────────
const BorderRadius kBorderRadiusXs  = BorderRadius.all(Radius.circular(kRadiusXs));
const BorderRadius kBorderRadiusSm  = BorderRadius.all(Radius.circular(kRadiusSm));
const BorderRadius kBorderRadiusMd  = BorderRadius.all(Radius.circular(kRadiusMd));
const BorderRadius kBorderRadiusLg  = BorderRadius.all(Radius.circular(kRadiusLg));
const BorderRadius kBorderRadiusXl  = BorderRadius.all(Radius.circular(kRadiusXl));

// Solo top (bottom sheets)
const BorderRadius kBorderRadiusTopMd = BorderRadius.vertical(top: Radius.circular(kRadiusMd));
const BorderRadius kBorderRadiusTopXl = BorderRadius.vertical(top: Radius.circular(kRadiusXl));

// ─────────────────────────────────────────────────────────────────────────────
// RoundedRectangleBorder presets
// ─────────────────────────────────────────────────────────────────────────────
const RoundedRectangleBorder kSheetShapeMd = RoundedRectangleBorder(
  borderRadius: kBorderRadiusTopMd,
);
const RoundedRectangleBorder kSheetShapeXl = RoundedRectangleBorder(
  borderRadius: kBorderRadiusTopXl,
);
const RoundedRectangleBorder kCardShapeMd = RoundedRectangleBorder(
  borderRadius: kBorderRadiusMd,
);

// ─────────────────────────────────────────────────────────────────────────────
// AppBar height
// ─────────────────────────────────────────────────────────────────────────────
const Size kAppBarSize    = Size.fromHeight(56);
const Size kAppBarSizeLg  = Size.fromHeight(72);

// ─────────────────────────────────────────────────────────────────────────────
// Bottom sheet height factors
// ─────────────────────────────────────────────────────────────────────────────
const double kSheetHeightSm  = 0.4;
const double kSheetHeightMd  = 0.6;
const double kSheetHeightLg  = 0.85;
const double kSheetHeightXl  = 0.92;

// ─────────────────────────────────────────────────────────────────────────────
// Íconos / imágenes
// ─────────────────────────────────────────────────────────────────────────────
const double kIconSm   = 16.0;
const double kIconMd   = 24.0;
const double kIconLg   = 32.0;
const double kIconXl   = 48.0;
const double kIconXxl  = 64.0;

// ─────────────────────────────────────────────────────────────────────────────
// Botones
// ─────────────────────────────────────────────────────────────────────────────
const double kBtnHeight     = 52.0;
const double kBtnHeightSm   = 40.0;
const double kBtnHeightLg   = 60.0;
const double kBtnRadiusMd   = kRadiusMd;
