import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ResultScreen.dart';
import 'VowelsQuizScreen.dart'; // Ensure this path is correct

class FoodQuizScreen extends StatefulWidget {
  @override
  _FoodQuizScreenState createState() => _FoodQuizScreenState();
}

class _FoodQuizScreenState extends State<FoodQuizScreen> {
  final List<Question> questions = [
    Question("What is 'Rice' in Korean?", ["밥", "면", "김치", "닭고기"], "밥"),
    Question("What is 'Noodles' in Korean?", ["김치", "밥", "면", "과일"], "면"),
    Question("What is 'Kimchi' in Korean?", ["김치", "쌈", "밥", "국"], "김치"),
    Question("What is 'Chicken' in Korean?", ["생선", "소고기", "닭고기", "돼지고기"], "닭고기"),
    Question("What is 'Pork' in Korean?", ["돼지고기", "소고기", "닭고기", "면"], "돼지고기"),
    Question("What is 'Beef' in Korean?", ["소고기", "돼지고기", "닭고기", "밥"], "소고기"),
    Question("What is 'Soup' in Korean?", ["국", "면", "밥", "김치"], "국"),
    Question("What is 'Fruit' in Korean?", ["채소", "과일", "김치", "쌀"], "과일"),
    Question("What is 'Vegetable' in Korean?", ["고기", "과일", "채소", "밥"], "채소"),
    Question("What is 'Salad' in Korean?", ["샐러드", "밥", "면", "김치"], "샐러드"),
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
      _showCompletionDialog("Korean Food Quiz Completed🎉");
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
      appBar: AppBar(title: const Text("Korean Food Quiz")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Text(
                "Q${currentQuestionIndex + 1}: ${question.questionText}",
                style: const TextStyle(fontSize: 20),
              ),
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