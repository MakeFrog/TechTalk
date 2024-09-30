import 'package:flutter/material.dart';

class AppColor extends ThemeExtension<AppColor> {
  static final AppColor _light = AppColor._(
    white: const Color(0xFFFFFFFF),
    black: const Color(0xFF09090B),
    brand1: const Color(0xFFEBEDFF),
    brand2: const Color(0xFF5C6DFF),
    brand3: const Color(0xFF3446EA),
    brand4: const Color(0xFF060E56),
    brand5: const Color(0xFFF7F8FC),
    gray1: const Color(0xFFECECF2),
    gray2: const Color(0xFFDCDCE9),
    gray3: const Color(0xFFA2A2B2),
    gray4: const Color(0xFF71717E),
    gray5: const Color(0xFF42424A),
    gray6: const Color(0xFF282831),
    gray7: const Color(0xFF09090B),
    background1: const Color(0xFFF6F6F9),
    red1: const Color(0xFFFFE4E8),
    red2: const Color(0xFFFF445A),
    red3: const Color(0xFFF62B44),
    blue1: const Color(0xFFEDEFFF),
    blue2: const Color(0xFF5C6DFF),
    green1: const Color(0xFF79F09A),
    green2: const Color(0xFF30DE80),
    green3: const Color(0xFF02C875),
    purple1: const Color(0xFFF4EDFF),
    purple2: const Color(0xFF8D3EFF),
  );

  static final AppColor _dark = AppColor._(
    white: const Color(0xFFFFFFFF),
    black: const Color(0xFF09090B),
    brand1: const Color(0xFFEBEDFF),
    brand2: const Color(0xFF5C6DFF),
    brand3: const Color(0xFF3446EA),
    brand4: const Color(0xFF060E56),
    brand5: const Color(0xFFF7F8FC),
    gray1: const Color(0xFFECECF2),
    gray2: const Color(0xFFDCDCE9),
    gray3: const Color(0xFFA2A2B2),
    gray4: const Color(0xFF71717E),
    gray5: const Color(0xFF42424A),
    gray6: const Color(0xFF282831),
    gray7: const Color(0xFF09090B),
    background1: const Color(0xFFF6F6F9),
    red1: const Color(0xFFFFE4E8),
    red2: const Color(0xFFFF445A),
    red3: const Color(0xFFF62B44),
    blue1: const Color(0xFFEDEFFF),
    blue2: const Color(0xFF5C6DFF),
    green1: const Color(0xFF79F09A),
    green2: const Color(0xFF30DE80),
    green3: const Color(0xFF02C875),
    purple1: const Color(0xFFF4EDFF),
    purple2: const Color(0xFF8D3EFF),
  );
  factory AppColor() => _light;

  AppColor._({
    required this.white,
    required this.black,
    required this.brand1,
    required this.brand2,
    required this.brand3,
    required this.brand4,
    required this.brand5,
    required this.gray1,
    required this.gray2,
    required this.gray3,
    required this.gray4,
    required this.gray5,
    required this.gray6,
    required this.gray7,
    required this.background1,
    required this.red1,
    required this.red2,
    required this.red3,
    required this.blue1,
    required this.blue2,
    required this.green1,
    required this.green2,
    required this.green3,
    required this.purple1,
    required this.purple2,
  });

  factory AppColor.dark() => _dark;

  final Color white;
  final Color black;
  final Color brand1;
  final Color brand2;
  final Color brand3;
  final Color brand4;
  final Color brand5;
  final Color gray1;
  final Color gray2;
  final Color gray3;
  final Color gray4;
  final Color gray5;
  final Color gray6;
  final Color gray7;
  final Color background1;
  final Color red1;
  final Color red2;
  final Color red3;
  final Color blue1;
  final Color blue2;
  final Color green1;
  final Color green2;
  final Color green3;
  final Color purple1;
  final Color purple2;

  static late BuildContext _context;
  static void init(BuildContext context) => _context = context;

  static AppColor get of => Theme.of(_context).extension<AppColor>()!;
  static AppColor? get maybeOf => Theme.of(_context).extension<AppColor>();

  @override
  ThemeExtension<AppColor> copyWith({
    Color? white,
    Color? black,
    Color? brand1,
    Color? brand2,
    Color? brand3,
    Color? brand4,
    Color? brand5,
    Color? gray1,
    Color? gray2,
    Color? gray3,
    Color? gray4,
    Color? gray5,
    Color? gray6,
    Color? gray7,
    Color? background1,
    Color? red1,
    Color? red2,
    Color? red3,
    Color? blue1,
    Color? blue2,
    Color? green1,
    Color? green2,
    Color? green3,
    Color? purple1,
    Color? purple2,
  }) {
    return AppColor._(
      white: white ?? this.white,
      black: black ?? this.black,
      brand1: brand1 ?? this.brand1,
      brand2: brand2 ?? this.brand2,
      brand3: brand3 ?? this.brand3,
      brand4: brand4 ?? this.brand4,
      brand5: brand5 ?? this.brand5,
      gray1: gray1 ?? this.gray1,
      gray2: gray2 ?? this.gray2,
      gray3: gray3 ?? this.gray3,
      gray4: gray4 ?? this.gray4,
      gray5: gray5 ?? this.gray5,
      gray6: gray6 ?? this.gray6,
      gray7: gray7 ?? this.gray7,
      background1: background1 ?? this.background1,
      red1: red1 ?? this.red1,
      red2: red2 ?? this.red2,
      red3: red3 ?? this.red3,
      blue1: blue1 ?? this.blue1,
      blue2: blue2 ?? this.blue2,
      green1: green1 ?? this.green1,
      green2: green2 ?? this.green2,
      green3: green3 ?? this.green3,
      purple1: purple1 ?? this.purple1,
      purple2: purple2 ?? this.purple2,
    );
  }

  @override
  ThemeExtension<AppColor> lerp(
    covariant ThemeExtension<AppColor>? other,
    double t,
  ) {
    if (other is! AppColor) {
      return this;
    }
    return AppColor._(
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      brand1: Color.lerp(brand1, other.brand1, t)!,
      brand2: Color.lerp(brand2, other.brand2, t)!,
      brand3: Color.lerp(brand3, other.brand3, t)!,
      brand4: Color.lerp(brand4, other.brand4, t)!,
      brand5: Color.lerp(brand5, other.brand5, t)!,
      gray1: Color.lerp(gray1, other.gray1, t)!,
      gray2: Color.lerp(gray2, other.gray2, t)!,
      gray3: Color.lerp(gray3, other.gray3, t)!,
      gray4: Color.lerp(gray4, other.gray4, t)!,
      gray5: Color.lerp(gray5, other.gray5, t)!,
      gray6: Color.lerp(gray6, other.gray6, t)!,
      gray7: Color.lerp(gray7, other.gray7, t)!,
      background1: Color.lerp(background1, other.background1, t)!,
      red1: Color.lerp(red1, other.red1, t)!,
      red2: Color.lerp(red2, other.red2, t)!,
      red3: Color.lerp(red3, other.red3, t)!,
      blue1: Color.lerp(blue1, other.blue1, t)!,
      blue2: Color.lerp(blue2, other.blue2, t)!,
      green1: Color.lerp(green1, other.green1, t)!,
      green2: Color.lerp(green2, other.green2, t)!,
      green3: Color.lerp(green3, other.green3, t)!,
      purple1: Color.lerp(purple1, other.purple1, t)!,
      purple2: Color.lerp(purple2, other.purple2, t)!,
    );
  }
}
