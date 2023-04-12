import 'package:flutter/painting.dart';

abstract class AppInset {
  AppInset._();

  /* 얘네 꼭 필요한가? */
  static const top4 = EdgeInsets.only(top: 4);
  static const top6 = EdgeInsets.only(top: 6);
  static const top8 = EdgeInsets.only(top: 8);
  static const top10 = EdgeInsets.only(top: 10);
  static const top12 = EdgeInsets.only(top: 12);
  static const top16 = EdgeInsets.only(top: 16);
  static const top20 = EdgeInsets.only(top: 20);
  static const top24 = EdgeInsets.only(top: 24);
  static const top32 = EdgeInsets.only(top: 32);
  static const top40 = EdgeInsets.only(top: 40);
  static const top56 = EdgeInsets.only(top: 56);
  static const top72 = EdgeInsets.only(top: 72);
  static const bottom4 = EdgeInsets.only(bottom: 4);
  static const bottom6 = EdgeInsets.only(bottom: 6);
  static const bottom8 = EdgeInsets.only(bottom: 8);
  static const bottom12 = EdgeInsets.only(bottom: 12);
  static const bottom14 = EdgeInsets.only(bottom: 14);
  static const bottom16 = EdgeInsets.only(bottom: 16);
  static const bottom20 = EdgeInsets.only(bottom: 20);
  static const bottom24 = EdgeInsets.only(bottom: 24);
  static const bottom32 = EdgeInsets.only(bottom: 32);
  static const bottom36 = EdgeInsets.only(bottom: 36);
  static const bottom46 = EdgeInsets.only(bottom: 46);
  static const bottom64 = EdgeInsets.only(bottom: 64);
  static const bottom84 = EdgeInsets.only(bottom: 84);
  static const bottom104 = EdgeInsets.only(bottom: 104);
  static const left4 = EdgeInsets.only(left: 8);
  static const left8 = EdgeInsets.only(left: 8);
  static const left10 = EdgeInsets.only(left: 10);
  static const left12 = EdgeInsets.only(bottom: 12);
  static const left16 = EdgeInsets.only(left: 16);
  static const left24 = EdgeInsets.only(left: 24);
  static const right4 = EdgeInsets.only(right: 4);
  static const right8 = EdgeInsets.only(right: 8);
  static const right12 = EdgeInsets.only(right: 12);
  static const right14 = EdgeInsets.only(right: 14);
  static const right16 = EdgeInsets.only(right: 16);

  static const all2 = EdgeInsets.all(2);
  static const all4 = EdgeInsets.all(4);
  static const all8 = EdgeInsets.all(8);
  static const all10 = EdgeInsets.all(10);
  static const all12 = EdgeInsets.all(12);
  static const all16 = EdgeInsets.all(16);
  static const all20 = EdgeInsets.all(20);
  static const all24 = EdgeInsets.all(24);
  static const all28 = EdgeInsets.all(28);

  static const vertical1 = EdgeInsets.symmetric(vertical: 1);
  static const vertical2 = EdgeInsets.symmetric(vertical: 2);
  static const vertical3 = EdgeInsets.symmetric(vertical: 3);
  static const vertical4 = EdgeInsets.symmetric(vertical: 4);
  static const vertical6 = EdgeInsets.symmetric(vertical: 6);
  static const vertical8 = EdgeInsets.symmetric(vertical: 8);
  static const vertical12 = EdgeInsets.symmetric(vertical: 12);
  static const vertical14 = EdgeInsets.symmetric(vertical: 14);
  static const vertical15 = EdgeInsets.symmetric(vertical: 15);
  static const vertical16 = EdgeInsets.symmetric(vertical: 16);
  static const vertical20 = EdgeInsets.symmetric(vertical: 20);
  static const vertical22 = EdgeInsets.symmetric(vertical: 22);
  static const vertical24 = EdgeInsets.symmetric(vertical: 24);
  static const vertical28 = EdgeInsets.symmetric(vertical: 28);

  static const horizontal4 = EdgeInsets.symmetric(horizontal: 4);
  static const horizontal8 = EdgeInsets.symmetric(horizontal: 8);
  static const horizontal10 = EdgeInsets.symmetric(horizontal: 10);
  static const horizontal12 = EdgeInsets.symmetric(horizontal: 12);
  static const horizontal16 = EdgeInsets.symmetric(horizontal: 16);
  static const horizontal20 = EdgeInsets.symmetric(horizontal: 20);
  static const horizontal24 = EdgeInsets.symmetric(horizontal: 24);
  static const horizontal26 = EdgeInsets.symmetric(horizontal: 26);
  static const horizontal28 = EdgeInsets.symmetric(horizontal: 28);
  static const horizontal60 = EdgeInsets.symmetric(horizontal: 60);

  /* Else*/
  static const left12right10 = EdgeInsets.only(left: 12, right: 10);
  static const top40else16 =
  EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16);
  static const top16bottom24 = EdgeInsets.only(top: 16, bottom: 24);
  static const top24bottom20 = EdgeInsets.only(top: 24, bottom: 20);
}

extension EdgeInsetsExtension on EdgeInsets {
  static EdgeInsets get all2 => AppInset.all2;

  static EdgeInsets get all4 => AppInset.all4;

  static EdgeInsets get all8 => AppInset.all8;

  static EdgeInsets get all12 => AppInset.all12;

  static EdgeInsets get all16 => AppInset.all16;

  static EdgeInsets get all20 => AppInset.all20;

  static EdgeInsets get all24 => AppInset.all24;

  static EdgeInsets get all28 => AppInset.all28;

  static EdgeInsets get vertical4 => AppInset.vertical4;

  static EdgeInsets get vertical8 => AppInset.vertical8;

  static EdgeInsets get vertical12 => AppInset.vertical12;

  static EdgeInsets get vertical16 => AppInset.vertical16;

  static EdgeInsets get vertical20 => AppInset.vertical20;

  static EdgeInsets get vertical24 => AppInset.vertical24;

  static EdgeInsets get vertical28 => AppInset.vertical28;

  static EdgeInsets get horizontal4 => AppInset.horizontal4;

  static EdgeInsets get horizontal8 => AppInset.horizontal8;

  static EdgeInsets get horizontal12 => AppInset.horizontal12;

  static EdgeInsets get horizontal16 => AppInset.horizontal16;

  static EdgeInsets get horizontal20 => AppInset.horizontal20;

  static EdgeInsets get horizontal24 => AppInset.horizontal24;

  static EdgeInsets get horizontal28 => AppInset.horizontal28;
}
