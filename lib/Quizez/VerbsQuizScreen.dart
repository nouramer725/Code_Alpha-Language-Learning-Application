import 'package:flutter/material.dart';
import 'ResultScreen.dart'; // Make sure this path is correct
import 'VowelsQuizScreen.dart';

class VerbsQuizScreen extends StatefulWidget {
  @override
  _VerbsQuizScreenState createState() => _VerbsQuizScreenState();
}

class _VerbsQuizScreenState extends State<VerbsQuizScreen> {
  final List<Question> questions = [
    Question("Run", ["달리다", "걷다", "먹다", "자다"], "달리다"),
    Question("To eat", ["가다", "보다", "먹다", "하다"], "먹다"),
    Question("가다", ["To go", "To see", "To eat", "To run"], "To go"),
    Question("To sleep", ["자다", "일어나다", "공부하다", "주다"], "자다"),
    Question("Study", ["공부하다", "가르치다", "배우다", "이해하다"], "공부하다"),
    Question("To give", ["주다", "받다", "하다", "걷다"], "주다"),
    Question("To read", ["읽다", "쓰다", "보내다", "듣다"], "읽다"),
    Question("Write", ["쓰다", "읽다", "보다", "듣다"], "쓰다"),
    Question("To drink", ["마시다", "보다", "먹다", "자다"], "마시다"),
    Question("To see", ["보다", "가다", "오다", "자다"], "보다"),
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
      appBar: AppBar(title: const Text("Verbs Quiz")),
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
                backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
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
