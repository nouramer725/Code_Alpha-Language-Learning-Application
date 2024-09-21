import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Welcome_Screen.dart';  // Your BasicApplication screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('darkMode') ?? false;

  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;

  MyApp({required this.isDarkMode});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ValueNotifier<bool> _themeNotifier;

  @override
  void initState() {
    super.initState();
    _themeNotifier = ValueNotifier(widget.isDarkMode);
  }

  void _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _themeNotifier.value = !_themeNotifier.value;
      prefs.setBool('darkMode', _themeNotifier.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _themeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: WelcomeScreen(toggleTheme: _toggleTheme),  // Start with WelcomeScreen
        );
      },
    );
  }
}
