import 'package:flutter/material.dart';
import 'package:nodelabs_caseapp_sinflix/features/sign_in/view/sign_in_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SinFlix',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFE50914)),
      ),
      home: const SignInScreen(),
    );
  }
}
