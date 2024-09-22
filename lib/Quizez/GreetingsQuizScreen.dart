import 'package:flutter/material.dart';
import 'ResultScreen.dart'; // Make sure this path is correct
import 'VowelsQuizScreen.dart';

class GreetingQuizScreen extends StatefulWidget {
  @override
  _GreetingQuizScreenState createState() => _GreetingQuizScreenState();
}

class _GreetingQuizScreenState extends State<GreetingQuizScreen> {
  final List<Question> questions = [
    Question("How do you say 'Hello' in Korean?", ["안녕하세요", "안녕", "잘가", "감사합니다"], "안녕하세요"),
    Question("How do you say 'Goodbye' in Korean?", ["안녕", "잘가", "안녕하세요", "고맙습니다"], "잘가"),
    Question("How do you say 'Thank you' in Korean?", ["고맙습니다", "안녕", "안녕하세요", "잘가"], "고맙습니다"),
    Question("How do you say 'Nice to meet you' in Korean?", ["안녕", "만나서 반갑습니다", "잘가", "감사합니다"], "만나서 반갑습니다"),
    Question("How do you say 'Good morning' in Korean?", ["안녕하세요", "좋은 아침", "안녕", "잘가"], "좋은 아침"),
    Question("How do you say 'Good night' in Korean?", ["안녕", "잘 자", "안녕하세요", "고맙습니다"], "잘 자"),
    Question("How do you say 'See you later' in Korean?", ["안녕하세요", "또 봐요", "잘가", "감사합니다"], "또 봐요"),
    Question("How do you say 'Excuse me' in Korean?", ["실례합니다", "안녕하세요", "잘가", "감사합니다"], "실례합니다"),
    Question("How do you say 'I'm sorry' in Korean?", ["죄송합니다", "안녕", "안녕하세요", "잘가"], "죄송합니다"),
    Question("How do you say 'How are you?' in Korean?", ["잘 지내세요?", "안녕하세요", "감사합니다", "잘가"], "잘 지내세요?"),
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
      appBar: AppBar(title: const Text("Korean Greetings Quiz")),
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
