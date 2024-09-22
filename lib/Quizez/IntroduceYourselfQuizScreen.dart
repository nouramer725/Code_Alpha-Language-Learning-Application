import 'package:flutter/material.dart';
import 'ResultScreen.dart'; // Make sure this path is correct
import 'VowelsQuizScreen.dart';

class IntroduceYourselfQuizScreen extends StatefulWidget {
  @override
  _IntroduceYourselfQuizScreenState createState() => _IntroduceYourselfQuizScreenState();
}

class _IntroduceYourselfQuizScreenState extends State<IntroduceYourselfQuizScreen> {
  final List<Question> questions = [
    Question("How do you say 'My name is' in Korean?", ["제 이름은", "안녕하세요", "저는", "잘가"], "제 이름은"),
    Question("How do you say 'I am from' in Korean?", ["저는 ~에서 왔습니다", "제 이름은", "안녕하세요", "잘가"], "저는 ~에서 왔습니다"),
    Question("How do you say 'I am' in Korean?", ["저는", "제 이름은", "안녕하세요", "고맙습니다"], "저는"),
    Question("How do you say 'I like' in Korean?", ["저는 좋아합니다", "제 이름은", "안녕하세요", "잘가"], "저는 좋아합니다"),
    Question("How do you say 'I am a student' in Korean?", ["저는 학생입니다", "제 이름은", "안녕하세요", "잘가"], "저는 학생입니다"),
    Question("How do you say 'I am learning Korean' in Korean?", ["저는 한국어를 배우고 있습니다", "안녕하세요", "제 이름은", "잘가"], "저는 한국어를 배우고 있습니다"),
    Question("How do you say 'I live in' in Korean?", ["저는 ~에 살고 있습니다", "안녕하세요", "제 이름은", "잘가"], "저는 ~에 살고 있습니다"),
    Question("How do you say 'I work as' in Korean?", ["저는 ~에서 일하고 있습니다", "안녕하세요", "제 이름은", "잘가"], "저는 ~에서 일하고 있습니다"),
    Question("How do you say 'Nice to meet you' in Korean?", ["만나서 반갑습니다", "안녕하세요", "잘가", "고맙습니다"], "만나서 반갑습니다"),
    Question("How do you say 'I am happy' in Korean?", ["저는 행복합니다", "안녕하세요", "제 이름은", "잘가"], "저는 행복합니다"),
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
      appBar: AppBar(title: const Text("Introduce Yourself Quiz")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
