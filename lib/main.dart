import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:nodelabs_caseapp_sinflix/core/consts/colors.dart";
import "package:nodelabs_caseapp_sinflix/features/sign_in/presentation/views/sign_in_screen.dart";

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SinFlix",
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFE50914),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: kColorBlack,
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          headlineSmall: GoogleFonts.poppins(
            color: kColorWhite,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          titleLarge: GoogleFonts.poppins(
            color: kColorWhite,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          titleMedium: GoogleFonts.poppins(
            color: kColorWhite,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
          titleSmall: GoogleFonts.poppins(
            color: kColorWhite,
            fontWeight: FontWeight.w400,
            fontSize: 13,
          ),
          bodyMedium: GoogleFonts.poppins(color: kColorWhite, fontSize: 12),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(kColorBrand),
            foregroundColor: WidgetStatePropertyAll(kColorWhite),
            padding: WidgetStatePropertyAll(EdgeInsets.all(17.16)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            ),
            textStyle: WidgetStatePropertyAll(
              GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.all(10.17)),
            iconColor: WidgetStatePropertyAll(kColorWhite),
            backgroundColor: WidgetStatePropertyAll(kColorWhiteA10),
            iconSize: WidgetStatePropertyAll(24),
            shape: WidgetStatePropertyAll(
              CircleBorder(
                side: BorderSide(
                  color: kColorWhiteA20,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
            ),
          ),
        ),
      ),
      home: const SignInScreen(),
    );
  }
}
