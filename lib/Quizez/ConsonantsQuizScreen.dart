import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ResultScreen.dart';
import 'VowelsQuizScreen.dart'; // Ensure this path is correct

class ConsonantsQuizScreen extends StatefulWidget {
  @override
  _ConsonantsQuizScreenState createState() => _ConsonantsQuizScreenState();
}

class _ConsonantsQuizScreenState extends State<ConsonantsQuizScreen> {
  final List<Question> questions = [
    Question("What is the consonant sound for 'ㄱ'?", ["g", "k", "n", "t"], "g"),
    Question("What is the consonant sound for 'ㄴ'?", ["n", "m", "b", "d"], "n"),
    Question("What is the consonant sound for 'ㄷ'?", ["d", "t", "g", "k"], "d"),
    Question("What is the consonant sound for 'ㄹ'?", ["l", "r", "m", "n"], "r"),
    Question("What is the consonant sound for 'ㅁ'?", ["m", "n", "p", "b"], "m"),
    Question("What is the consonant sound for 'ㅂ'?", ["b", "p", "m", "n"], "b"),
    Question("What is the consonant sound for 'ㅅ'?", ["s", "t", "d", "g"], "s"),
    Question("What is the consonant sound for 'ㅇ'?", ["ng", "m", "b", "d"], "ng"),
    Question("What is the consonant sound for 'ㅈ'?", ["j", "t", "g", "n"], "j"),
    Question("What is the consonant sound for 'ㅊ'?", ["ch", "c", "k", "g"], "ch"),
  ];

  int currentQuestionIndex = 0;
  List<String> selectedAnswers = [];

  void _submitAnswer(String answer) {
    selectedAnswers.add(answer);
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _showCompletionDialog("Korean Consonants Quiz Completed🎉");
    }
  }

  void _showCompletionDialog(String achievement) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Congratulations! 🎉"),
        content: Text("You've completed the $achievement!"),
        actions: [
          TextButton(
            onPressed: () {
              _addAchievement(achievement);
              Navigator.of(context).pop();
              _showResultScreen();
            },
            child: const Text("Okay"),
          ),
        ],
      ),
    );
  }

  void _addAchievement(String achievement) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> achievements = prefs.getStringList("achievements") ?? [];
    achievements.add(achievement);
    await prefs.setStringList("achievements", achievements);
  }

  void _showResultScreen() {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i].correctAnswer) {
        score++;
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          score: score,
          selectedAnswers: selectedAnswers,
          questions: questions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(title: const Text("Korean Consonants Quiz")),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Q${currentQuestionIndex + 1}: ${question.questionText}",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            ...question.options.map((option) {
              return ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                ),
                onPressed: () => _submitAnswer(option),
                child: Text(
                  option,
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

