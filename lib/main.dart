import 'package:flutter/material.dart';
import 'package:flutter_amazon/common/widgets/bottom_bar.dart';
import 'package:flutter_amazon/constants/global_variables.dart';
import 'package:flutter_amazon/features/admin/screens/admin_screen.dart';
import 'package:flutter_amazon/features/auth/screens/auth_screen.dart';
import 'package:flutter_amazon/features/auth/services/auth_service.dart';
import 'package:flutter_amazon/providers/user_provider.dart';
import 'package:flutter_amazon/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context);
  }

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
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty ? Provider.of<UserProvider>(context).user.type == 'user' ? const BottomBar() : AdminScreen() : const AuthScreen(),
    );
  }
}