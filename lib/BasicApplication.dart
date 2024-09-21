import 'package:flutter/material.dart';
import 'package:learning/Screens/Community.dart';
import 'package:learning/Screens/Languages_Screen.dart';
import 'package:learning/Screens/Games.dart';
import 'package:learning/Screens/quizzez.dart';
import 'package:learning/Screens/Fun_Screen.dart';

class Basicapplication extends StatefulWidget {
  final VoidCallback toggleTheme;

  Basicapplication({required this.toggleTheme});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Basicapplication> {
  int _selectedIndex = 0;

  // Update the home widget to use the new MainHomeScreen
  List<Widget> _widgetOptions = [
    LanguagesScreen(),
    ShieldScreen(),
    QuizHomePage(),
    GamifiedLearningScreen(),
    ForumScreen()
  ];

  // Function to change the selected index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Image.asset('assets/images/OIF.jpeg',fit: BoxFit.cover,), // Replace with your image path
        ),
        actions: [
          IconButton(
            icon: Icon(Theme.of(context).brightness == Brightness.dark ? Icons.dark_mode : Icons.light_mode),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Allows for more than 3 icons
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red, // Active icon color
        unselectedItemColor: Colors.grey, // Inactive icon color
        selectedIconTheme: IconThemeData(size: 30), // Increase size of selected icon
        unselectedIconTheme: IconThemeData(size: 25), // Normal size for unselected icons
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex ==0
                ? Transform.translate(
              offset: Offset(0, 0), // Raise the selected icon
              child: Text('한', style: TextStyle(fontSize: 24,)),
            )
                : Text('한', style: TextStyle(fontSize: 24)),
            label: 'Language',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Transform.translate(
              offset: Offset(0, 0), // Raise the selected icon
              child: Icon(Icons.interests_sharp),
            )
                : Icon(Icons.interests_sharp),
            label: 'Entertainment',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? Transform.translate(
              offset: Offset(0, 0), // Raise the selected icon
              child: Icon(Icons.quiz_outlined),
            )
                : Icon(Icons.quiz_outlined),
            label: 'Quizzes',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? Transform.translate(
              offset: Offset(0, 0), // Raise the selected icon
              child: Icon(Icons.games),
            )
                : Icon(Icons.games),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 4
                ? Transform.translate(
              offset: Offset(0, 0), // Raise the selected icon
              child: Icon(Icons.format_align_center_rounded),
            )
                : Icon(Icons.format_align_center_rounded),
            label: 'Community',
          ),
        ],
      ),
    );
  }
}
