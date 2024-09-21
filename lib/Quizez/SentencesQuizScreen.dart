import 'package:flutter/material.dart';
import 'ResultScreen.dart'; // Make sure this path is correct
import 'VowelsQuizScreen.dart';

class SentenceQuizScreen extends StatefulWidget {
  @override
  _SentenceQuizScreenState createState() => _SentenceQuizScreenState();
}

class _SentenceQuizScreenState extends State<SentenceQuizScreen> {
  final List<Question> questions = [
    Question("안녕하세요", ["Hello", "Goodbye", "Thank you", "Yes"], "Hello"),
    Question("감사합니다", ["Please", "Thank you", "Sorry", "Hello"], "Thank you"),
    Question("Where are you going?", ["어디 가세요?", "무슨 일이에요?", "안녕하세요", "감사합니다"], "어디 가세요?"),
    Question("I love you", ["사랑해요", "좋아요", "안녕하세요", "감사합니다"], "사랑해요"),
    Question("What's your name?", ["이름이 뭐예요?", "어디 가세요?", "안녕", "고맙습니다"], "이름이 뭐예요?"),
    Question("I am happy", ["나는 행복해요", "나는 슬퍼요", "나는 배고파요", "나는 졸려요"], "나는 행복해요"),
    Question("Good night", ["안녕히 주무세요", "안녕하세요", "고맙습니다", "잘가"], "안녕히 주무세요"),
    Question("I am a student", ["저는 학생입니다", "저는 선생님입니다", "저는 의사입니다", "저는 회사원입니다"], "저는 학생입니다"),
    Question("Thank you very much", ["대단히 감사합니다", "고맙습니다", "안녕하세요", "잘가"], "대단히 감사합니다"),
    Question("I like Korean food", ["한국 음식을 좋아해요", "나는 배고파요", "나는 한국어를 공부해요", "안녕하세요"], "한국 음식을 좋아해요"),
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
      appBar: AppBar(title: const Text("Sentence Quiz")),
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
                backgroundColor: MaterialStateProperty.all(Colors.red),
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
