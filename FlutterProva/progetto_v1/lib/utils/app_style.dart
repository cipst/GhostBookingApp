import 'package:flutter/material.dart';

class Styles {
  static Color textColor = const Color(0xFF3b3b3b);
  static Color bgColor = const Color(0xFFEEEDF2);
  static Color orangeColor = const Color(0xFFF37B67);
  static Color blueColor = const Color(0xFF526799);
  static Color successColor = const Color(0xFF00D23C);
  static Color errorColor = const Color(0xFFEE296B);
  static Color greyColor = const Color(0xFF818181);

  static TextStyle textStyle = TextStyle(
    fontSize: 16,
    color: textColor,
    fontWeight: FontWeight.w500,
  );
  static TextStyle titleStyle = const TextStyle(
    fontSize: 32,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headLineStyle = TextStyle(
    fontSize: 26,
    color: textColor,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headLineStyle2 = TextStyle(
    fontSize: 21,
    color: textColor,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headLineStyle3 = TextStyle(
    fontSize: 17,
    color: Colors.grey.shade500,
    fontWeight: FontWeight.w500,
  );
  static TextStyle headLineStyle4 = TextStyle(
    fontSize: 14,
    color: Colors.grey.shade500,
    fontWeight: FontWeight.w500,
  );

  static ButtonStyle blueButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: blueColor,
  );
  static ButtonStyle orangeButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: orangeColor,
  );
  static ButtonStyle errorButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: errorColor,
  );
  static ButtonStyle successButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: successColor,
  );
  static ButtonStyle blueButtonStyleOutline = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: blueColor,
    side: BorderSide(
        color: blueColor
    ),
  );
  static ButtonStyle orangeButtonStyleOutline = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: orangeColor,
    side: BorderSide(
        color: orangeColor
    ),
  );
  static ButtonStyle errorButtonStyleOutline = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: errorColor,
    side: BorderSide(
        color: errorColor
    ),
  );
  static ButtonStyle successButtonStyleOutline = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: successColor,
    side: BorderSide(
        color: successColor
    ),
  );

}
