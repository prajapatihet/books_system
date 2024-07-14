import 'package:flutter/material.dart';

class TColor {
  static Color get primary => const Color.fromARGB(255, 128, 179, 255);
  static Color get primaryLight => const Color.fromARGB(255, 161, 174, 193);
  static Color get text => const Color(0xff212121);
  static Color get subTitle => const Color(0xff212121).withOpacity(0.5);

  static Color get color1 => const Color.fromARGB(255, 35, 76, 124);
  static Color get color2 => const Color.fromARGB(255, 173, 82, 59);

  static Color get dColor => const Color.fromARGB(255, 255, 255, 255);

  static Color get textbox =>
      const Color.fromARGB(255, 188, 188, 188).withOpacity(0.6);

  static List<Color> get button => const [
        Color.fromARGB(255, 128, 179, 255),
        Color.fromARGB(255, 161, 174, 193)
      ];

  static List<Color> get searchBGColor => const [
        Color(0xffB7143C),
        Color(0xffE6A500),
        Color(0xffEF4C45),
        Color(0xffF46217),
        Color(0xff09ADE2),
        Color(0xffD36A43),
      ];
}
