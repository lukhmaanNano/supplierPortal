import 'package:flutter/material.dart';
import 'package:supplierportal/splash.dart';
import 'package:supplierportal/styles/common%20Color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.dark,
      scrollBehavior: const ScrollBehavior(
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        appBarTheme: AppBarTheme(
            backgroundColor: Styles.scaffoldBackgroundColor,
            titleTextStyle:
                const TextStyle(fontFamily: 'Eras Demi', fontSize: 20)),
        buttonTheme: const ButtonThemeData(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        checkboxTheme: CheckboxThemeData(
          shape: const CircleBorder(),
          checkColor: MaterialStateProperty.all(Colors.white),
          fillColor: MaterialStateProperty.all(const Color(0xFF21446F)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          ),
        ),
        dividerColor: buttonForeground,
        primaryColor: const Color(0xFF21446F),
        scaffoldBackgroundColor: Styles.scaffoldBackgroundColor,
        scrollbarTheme: Styles.scrollbarTheme,
      ),
      title: 'Supplier Portal',
      home: const Splash(),
    );
  }
}
