import 'package:flutter/material.dart';
import 'ResultScreen.dart'; // Make sure this path is correct
import 'VowelsQuizScreen.dart';

class FamilyMembersQuizScreen extends StatefulWidget {
  @override
  _FamilyMembersQuizScreenState createState() => _FamilyMembersQuizScreenState();
}

class _FamilyMembersQuizScreenState extends State<FamilyMembersQuizScreen> {
  final List<Question> questions = [
    Question("What is 'Mother' in Korean?", ["어머니", "아버지", "형", "누나"], "어머니"),
    Question("What is 'Father' in Korean?", ["어머니", "아버지", "형", "누나"], "아버지"),
    Question("What is 'Older Brother' in Korean?", ["형", "동생", "누나", "아버지"], "형"),
    Question("What is 'Older Sister' in Korean?", ["언니", "누나", "여동생", "어머니"], "누나"),
    Question("What is 'Younger Sibling' in Korean?", ["형", "동생", "누나", "아버지"], "동생"),
    Question("What is 'Grandfather' in Korean?", ["할아버지", "할머니", "삼촌", "이모"], "할아버지"),
    Question("What is 'Grandmother' in Korean?", ["할머니", "이모", "삼촌", "언니"], "할머니"),
    Question("What is 'Cousin' in Korean?", ["사촌", "조카", "형", "누나"], "사촌"),
    Question("What is 'Aunt' in Korean?", ["이모", "삼촌", "어머니", "여동생"], "이모"),
    Question("What is 'Uncle' in Korean?", ["이모", "삼촌", "형", "누나"], "삼촌"),
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
      _showResultScreen();
    }
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
      appBar: AppBar(title: const Text("Korean Family Members Quiz")),
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
