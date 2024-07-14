import 'package:flutter/material.dart';
import 'package:tracker/expenses.dart';
// import 'package:flutter/services.dart';

var KcolorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 120, 3, 5));
var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: Color.fromARGB(255, 5, 99, 124));
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((fa) {
  runApp(
    MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDarkColorScheme,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  backgroundColor: kDarkColorScheme.primaryContainer,
                  foregroundColor: kDarkColorScheme.onPrimaryContainer)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkColorScheme.primaryContainer,
                  foregroundColor: kDarkColorScheme.onPrimaryContainer)),
          cardTheme: const CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
        ),
        theme: ThemeData().copyWith(
            useMaterial3: true,
            colorScheme: KcolorScheme,
            appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: KcolorScheme.onPrimaryContainer,
              foregroundColor: KcolorScheme.primaryContainer,
            ),
            cardTheme: const CardTheme().copyWith(
                color: KcolorScheme.secondaryContainer,
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    backgroundColor: KcolorScheme.primaryContainer,
                    foregroundColor: KcolorScheme.onPrimaryContainer)),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: KcolorScheme.primaryContainer)),
            textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: KcolorScheme.onSecondaryContainer,
                    fontSize: 14))),
        themeMode: ThemeMode.system,
        // theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: true,
        home: const Expenses()),
  );
  // });
}
