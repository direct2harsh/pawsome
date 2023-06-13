import 'package:flutter/material.dart';
import 'package:pawsome/db/initialise_database.dart';
import 'package:pawsome/providers/bottom_nav_provider.dart';
import 'package:pawsome/screens/history_screen.dart';
import 'package:pawsome/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'package:flutter/cupertino.dart';

class BottomNavWidget extends StatefulWidget {
  const BottomNavWidget({super.key});

  @override
  State<BottomNavWidget> createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<BottomNavWidget> {
  @override
  void initState() {
    super.initState();
    initialiseDataBase();
  }

  final List<Widget> _tabs = [
    const HomeScreen(),
    const HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBarProvider>(
      builder: (context, provider, child) {
        int currentIndex = provider.currentTabIndex;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              currentIndex == 0 ? "Home" : "History",
            ),
            titleTextStyle: const TextStyle(
                color: Colors.purple,
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          body: _tabs[provider.currentTabIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            backgroundColor: Colors.white,
            currentIndex: currentIndex,
            useLegacyColorScheme: false,
            elevation: 2,
            enableFeedback: true,
            selectedItemColor: Colors.purple,
            items: const [
              BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: "History", icon: Icon(Icons.history))
            ],
            onTap: (value) => provider.setCurrentTabIndex = value,
          ),
        );
      },
    );
  }
}
