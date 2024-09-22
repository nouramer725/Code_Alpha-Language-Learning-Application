import 'package:flutter/material.dart';
import 'ResultScreen.dart';
import 'VowelsQuizScreen.dart'; // Make sure this path is correct

class KoreanCharactersAdditionQuizScreen extends StatefulWidget {
  @override
  _KoreanCharactersAdditionQuizScreenState createState() => _KoreanCharactersAdditionQuizScreenState();
}

class _KoreanCharactersAdditionQuizScreenState extends State<KoreanCharactersAdditionQuizScreen> {
  final List<Question> characterAdditionQuestions = [
    // Add consonant and vowel to form a syllable
    Question(
        "Combine 'ㄱ' and 'ㅏ'. What is the resulting syllable?",
        ["가", "카", "고", "거"],
        "가"
    ),
    Question(
        "Combine 'ㅂ' and 'ㅓ'. What is the resulting syllable?",
        ["버", "보", "부", "바"],
        "버"
    ),
    Question(
        "Combine 'ㄷ' and 'ㅜ'. What is the resulting syllable?",
        ["두", "도", "다", "더"],
        "두"
    ),
    Question(
        "Combine 'ㅅ' and 'ㅗ'. What is the resulting syllable?",
        ["소", "서", "수", "사"],
        "소"
    ),
    Question(
        "Combine 'ㅁ' and 'ㅣ'. What is the resulting syllable?",
        ["미", "모", "무", "마"],
        "미"
    ),
    Question(
        "Combine 'ㅎ' and 'ㅏ'. What is the resulting syllable?",
        ["하", "호", "후", "헤"],
        "하"
    ),
    Question(
        "Combine 'ㄹ' and 'ㅔ'. What is the resulting syllable?",
        ["레", "라", "루", "로"],
        "레"
    ),
    Question(
        "Combine 'ㄴ' and 'ㅗ'. What is the resulting syllable?",
        ["노", "나", "누", "네"],
        "노"
    ),
    Question(
        "Combine 'ㅋ' and 'ㅏ'. What is the resulting syllable?",
        ["카", "코", "쿠", "키"],
        "카"
    ),
    Question(
        "Combine 'ㅈ' and 'ㅜ'. What is the resulting syllable?",
        ["주", "조", "자", "저"],
        "주"
    ),
  ];

  int currentQuestionIndex = 0;
  List<String> selectedAnswers = [];

  void _submitAnswer(String answer) {
    selectedAnswers.add(answer);
    if (currentQuestionIndex < characterAdditionQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _showResultScreen();
    }
  }

  void _showResultScreen() {
    int score = 0;
    for (int i = 0; i < characterAdditionQuestions.length; i++) {
      if (selectedAnswers[i] == characterAdditionQuestions[i].correctAnswer) {
        score++;
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          score: score,
          selectedAnswers: selectedAnswers,
          questions: characterAdditionQuestions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = characterAdditionQuestions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(title: const Text("Korean Character Addition Quiz")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
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