import 'package:flutter/material.dart';
import 'package:pawsome/db/initialise_database.dart';
import 'package:pawsome/helpers/constants.dart';
import 'package:pawsome/main.dart';
import 'package:pawsome/providers/bottom_nav_provider.dart';
import 'package:pawsome/screens/history_screen.dart';
import 'package:pawsome/screens/home_screen.dart';
import 'package:provider/provider.dart';

class BottomNavWidget extends StatefulWidget {
  const BottomNavWidget({super.key});

  @override
  State<BottomNavWidget> createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<BottomNavWidget> {
  final List<Widget> _tabs = [
    const HomeScreen(),
    const HistoryScreen(),
  ];
// Initializind Database with Asset values
  @override
  void initState() {
    super.initState();
    initialiseDataBase();
  }

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // bool isDarkMode = MyApp.of(context).themeMode == ThemeMode.dark;
    return Consumer<BottomNavigationBarProvider>(
      builder: (context, provider, child) {
        int currentIndex = provider.currentTabIndex;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 45,
            centerTitle: true,
            title: Text(
              currentIndex == 0 ? "Home" : "History",
            ),
            titleTextStyle: const TextStyle(
                color: kColor, fontSize: 23, fontWeight: FontWeight.bold),
            actions: [
              IconButton(
                  tooltip: "Switch Theme",
                  onPressed: () {
                    MyApp.of(context).switchTheme();
                  },
                  icon: const Icon(
                    Icons.color_lens,
                    color: kColor,
                    size: 30,
                  ))
            ],
          ),
          body: PageView(
            controller: _pageController,
            children: _tabs,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            backgroundColor: Colors.white,
            currentIndex: currentIndex,
            useLegacyColorScheme: false,
            elevation: 2,
            enableFeedback: true,
            selectedItemColor: kColor,
            items: const [
              BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: "History", icon: Icon(Icons.history))
            ],
            onTap: (value) {
              provider.setCurrentTabIndex = value;
              _pageController.jumpToPage(value);
            },
          ),
        );
      },
    );
  }
}
