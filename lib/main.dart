import 'package:flutter/material.dart';
import 'package:pawsome/providers/bottom_nav_provider.dart';
import 'package:pawsome/providers/pets_provider.dart';
import 'package:pawsome/screens/home_screen.dart';
import 'package:pawsome/widgets/bottomnavbar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
    ChangeNotifierProvider(create: (_) => PetProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
   ThemeMode themeMode = ThemeMode.system;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pawsome',
      theme: ThemeData(brightness: Brightness.light, ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: themeMode,
      routes: {
        '/': (context) => const BottomNavWidget(),
      },
      initialRoute: "/",
    );
  }

  void switchTheme() {
    setState(() {
      if (themeMode == ThemeMode.dark) {
        themeMode = ThemeMode.light;
      } else {
        themeMode = ThemeMode.dark;
      }
    });
  }
}
