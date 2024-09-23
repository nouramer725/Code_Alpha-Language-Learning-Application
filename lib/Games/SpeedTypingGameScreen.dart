import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpeedTypingGameScreen extends StatefulWidget {
  @override
  _SpeedTypingGameScreenState createState() => _SpeedTypingGameScreenState();
}

class _SpeedTypingGameScreenState extends State<SpeedTypingGameScreen> {
  List<Map<String, String>> words = [
    {"I love you": "사랑해요"},
    {"Hello": "안녕하세요"},
    {"Thank you": "감사합니다"},
    {"Yes": "네"},
    {"No": "아니요"}
  ];

  int currentIndex = 0;
  String userInput = "";
  String feedbackMessage = "";

  void _checkAnswer() {
    if (userInput == words[currentIndex].values.first) {
      setState(() {
        feedbackMessage = "Correct!";
        // Move to the next question only if it's the last question
        if (currentIndex < words.length - 1) {
          currentIndex++;
          userInput = "";
        } else {
          // Show completion dialog if all questions are answered
          _showCompletionDialog();
        }
      });
    } else {
      setState(() {
        feedbackMessage = "Incorrect, try again!";
      });
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Congratulations!"),
          content: const Text("You've completed the speed typing game."),
          actions: <Widget>[
            TextButton(
              child: const Text("Okay"),
              onPressed: () async {
                await _saveAchievement();
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/achievementScreen');
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveAchievement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> gameAchievements = prefs.getStringList("gameAchievements") ?? [];
    if (!gameAchievements.contains("Completed Speed Typing Game")) {
      gameAchievements.add("Completed Speed Typing Game");
      await prefs.setStringList("gameAchievements", gameAchievements);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Korean Speed Typing Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Translate: ${words[currentIndex].keys.first}',
              style: const TextStyle(fontSize: 28,color: Colors.red),
            ),
            const SizedBox(height: 25),
            TextField(
              onChanged: (value) {
                setState(() {
                  userInput = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type in Korean',
                prefixIcon: Icon(Icons.language)
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: const Text("Submit",style: const TextStyle(fontSize: 15,color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              feedbackMessage,
              style: TextStyle(
                fontSize: 20,
                color: feedbackMessage == "Correct!" ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
