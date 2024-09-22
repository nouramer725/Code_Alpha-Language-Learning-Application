import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ResultScreen.dart';

class VowelsQuizScreen extends StatefulWidget {
  @override
  _VowelsQuizScreenState createState() => _VowelsQuizScreenState();
}

class _VowelsQuizScreenState extends State<VowelsQuizScreen> {
  final List<Question> questions = [
    Question("What is the vowel sound for 'ㅡ'?", ["eu", "i", "o", "e"], "eu"),
    Question("What is the vowel sound for 'ㅏ'?", ["a", "e", "i", "o"], "a"),
    Question("What is the vowel sound for 'ㅑ'?", ["ya", "ye", "yu", "o"], "ya"),
    Question("What is the vowel sound for 'ㅕ'?", ["yae", "yeo", "u", "i"], "yeo"),
    Question("What is the vowel sound for 'ㅗ'?", ["o", "u", "ae", "i"], "o"),
    Question("What is the vowel sound for 'ㅛ'?", ["yo", "yu", "i", "e"], "yo"),
    Question("What is the vowel sound for 'ㅓ'?", ["ae", "eo", "eu", "i"], "eo"),
    Question("What is the vowel sound for 'ㅜ'?", ["u", "yu", "o", "ae"], "u"),
    Question("What is the vowel sound for 'ㅠ'?", ["u", "yu", "e", "i"], "yu"),
    Question("What is the vowel sound for 'ㅣ'?", ["i", "e", "ae", "o"], "i"),
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
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i].correctAnswer) {
        score++;
      }
    }
    // Show completion dialog and add achievement
    _showCompletionDialog("Vowels Quiz Completed Completed🎉");
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
              _addAchievement(achievement); // Add achievement
              Navigator.of(context).pop(); // Close the dialog
              // Navigate to the results screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsScreen(
                    score: selectedAnswers.where((answer) => questions[selectedAnswers.indexOf(answer)].correctAnswer == answer).length,
                    selectedAnswers: selectedAnswers,
                    questions: questions,
                  ),
                ),
              );
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

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(title: const Text("Korean Vowels Quiz")),
      body: Column(
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
    );
  }
}

class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  Question(this.questionText, this.options, this.correctAnswer);
}
