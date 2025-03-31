import 'package:flutter/material.dart';

const GREEN_100 = Color(0XFFDCFCE7);
const GREEN_200 = Color(0XFFBBF7D0);
const GREEN_600 = Color(0XFF16A34A);
const GREEN_800 = Color(0XFF166534);

const STONE_50 = Color(0XFFFAFAF9);
const STONE_100 = Color(0XFFF5F5F4);
const STONE_200 = Color(0XFFE7E5E4);
const STONE_400 = Color(0XFFA8A29E);
const STONE_500 = Color(0XFF78716C);
const STONE_600 = Color(0XFF57534E);
const STONE_800 = Color(0XFF292524);

const RED_800 = Color(0XFF991B1B);

const M_2 = 2.0;
const M_4 = 4.0;
const M_8 = 8.0;
const M_10 = 10.0;
const M_16 = 16.0;
const M_24 = 24.0;

const W96 = 96.0;
const W104 = 104.0;

const H_8 = 8.0;
const H_3XS = 16.0;
const H_2XS = 18.0;
const H_SM = 24.0;
const H_72 = 72.0;

const W6 = 6.0;
const W14 = 14.0;
const W56 = 56.0;
const W3XS = 16.0;
const W2XS = 18.0;
const WSM = 24.0;

const P_0 = EdgeInsets.all(0);
const P_8 = EdgeInsets.all(8);
const PX_8 = EdgeInsets.symmetric(horizontal: 8);

const EI_8 = EdgeInsets.all(M_8);
const EI_16 = EdgeInsets.all(M_16);
const EI_24 = EdgeInsets.all(M_24);

final BORDER = Border.all(color: STONE_400);
const BORDER_T = Border(top: BorderSide(color: STONE_400));

const ROUNDED_MD = BorderRadius.all(Radius.circular(6));
const ROUNDED_LG = BorderRadius.all(Radius.circular(12));

const TEXT_XS = TextStyle(fontSize: 12, height: 1);
const TEXT_SM = TextStyle(fontSize: 14, height: 1.25);
const TEXT_MD = TextStyle(fontSize: 16);
const TEXT_LG = TextStyle(fontSize: 18, height: 1.75);
const TEXT_2XL = TextStyle(fontSize: 24, height: 2.25);

const TEXT_GREEN_800 = TextStyle(color: GREEN_800);

const TEXT_STONE_600 = TextStyle(color: STONE_600);
const TEXT_STONE_800 = TextStyle(color: STONE_800);

const TEXT_RED_800 = TextStyle(color: RED_800);

const LEADING_XS = TextStyle(height: 1);
const LEADING_MD = TextStyle(height: 1.5);
const LEADING_LG = TextStyle(height: 1.75);

const FONT_BOLD = TextStyle(fontWeight: FontWeight.bold);

/// Styles
final CUSTOM_FILLED_BUTTON = FilledButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: ROUNDED_LG,
  ),
  padding: P_0,
  minimumSize: Size.square(W56),
);
