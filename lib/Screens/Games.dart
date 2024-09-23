import 'package:flutter/material.dart';
import 'package:learning/Games/KoreanMatchingGameScreen.dart';
import 'package:learning/Games/MATCHING.dart';
import 'package:learning/Games/MemoryGameScreen.dart';
import 'package:learning/Games/SpeedTypingGameScreen.dart';
import 'package:learning/Games/TrueFalseGameScreen.dart';

import '../Games/match char.dart';


class FoodMatchingGame extends StatefulWidget {
  @override
  _FoodMatchingGameState createState() => _FoodMatchingGameState();
}

class _FoodMatchingGameState extends State<FoodMatchingGame> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Center(
              child: const Text(
                "EXPLORE OUR GAMES! ",
                style: TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: Column(
                children: [
                  _buildNavigationContainer("Korean Matching Game", Colors.blue, KoreanMatchingGameScreen()),
                  _buildNavigationContainer("Matching Game ", Colors.green, FoodMatchingGamee()),
                  _buildNavigationContainer("Matching Characters Game ", Colors.pinkAccent, MatchingChar()),
                  _buildNavigationContainer("Memory Game", Colors.orange, MemoryGameScreen()),
                  _buildNavigationContainer("Speed Typing Game", Colors.purple, SpeedTypingGameScreen()),
                  _buildNavigationContainer("True False Game ", Colors.red, TrueFalseGameScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationContainer(String title, Color color, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle( fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

