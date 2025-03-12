import 'package:flutter/material.dart';
import 'package:flutter_amazon/constants/global_variables.dart';
import 'package:flutter_amazon/features/auth/screens/auth_screen.dart';
import 'package:flutter_amazon/home_screen.dart';
import 'package:flutter_amazon/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Amazon",
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: GlobalVariables.backgroundColor,
            backgroundColor: GlobalVariables.secondaryColor,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: AuthScreen(),
    );
  }
}
