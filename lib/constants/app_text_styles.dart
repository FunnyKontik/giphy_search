import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final headerTextStyle = GoogleFonts.raleway(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
    ),
  );

  static final bodyTextStyle = GoogleFonts.raleway(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    ),
  );
}
