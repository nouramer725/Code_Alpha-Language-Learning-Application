import 'package:flutter/material.dart';
import 'ResultScreen.dart';
import 'VowelsQuizScreen.dart'; // Make sure this path is correct

class IntermediateGrammarQuizScreen extends StatefulWidget {
  @override
  _IntermediateGrammarQuizScreenState createState() => _IntermediateGrammarQuizScreenState();
}

class _IntermediateGrammarQuizScreenState extends State<IntermediateGrammarQuizScreen> {
  final List<Question> grammarQuestions = [
    // Korean to English questions
    Question(
      "-에서: 학교에서 공부해요.",
      ["I study at school.", "I teach at home.", "I eat at the park.", "I work at the library."],
      "I study at school.",
    ),
    Question(
      "-부터: 수업은 3시부터 시작해요.",
      ["The class starts at 3 PM.", "The meeting is at 2 PM.", "The movie starts at 5 PM.", "The event is at 6 PM."],
      "The class starts at 3 PM.",
    ),
    Question(
      "-았/었: 나는 어제 운동했어요.",
      ["I exercised yesterday.", "I studied yesterday.", "I read a book yesterday.", "I slept yesterday."],
      "I exercised yesterday.",
    ),
    Question(
      "-ㄹ 거예요: 내일 쇼핑할 거예요.",
      ["I will go shopping tomorrow.", "I will study tomorrow.", "I will eat tomorrow.", "I will exercise tomorrow."],
      "I will go shopping tomorrow.",
    ),
    Question(
      "-지 않다: 저는 그 영화를 보지 않았어요.",
      ["I did not watch that movie.", "I did not go to the park.", "I did not read the book.", "I did not eat dinner."],
      "I did not watch that movie.",
    ),
    // English to Korean questions
    Question(
      "I know about Korea.",
      ["한국에 대해 알아요.", "한국에 대해 몰라요.", "한국에 대해 배웠어요.", "한국에 대해 가르쳤어요."],
      "한국에 대해 알아요.",
    ),
    Question(
      "The teacher makes the students laugh.",
      ["선생님이 학생을 웃게 해요.", "선생님이 학생을 울게 해요.", "선생님이 학생을 가르쳐요.", "선생님이 학생을 모아줘요."],
      "선생님이 학생을 웃게 해요.",
    ),
    Question(
      "If it rains, I stay at home.",
      ["비가 오면 집에 있어요.", "비가 오면 밖에 나가요.", "비가 오면 공부해요.", "비가 오면 친구를 만나요."],
      "비가 오면 집에 있어요.",
    ),
    Question(
      "I am reading a book now.",
      ["저는 지금 책을 읽고 있어요.", "저는 지금 책을 쓰고 있어요.", "저는 지금 친구를 만나고 있어요.", "저는 지금 영화를 보고 있어요."],
      "저는 지금 책을 읽고 있어요.",
    ),
    Question(
      "I exercised yesterday.",
      ["나는 어제 운동했어요.", "나는 어제 공부했어요.", "나는 어제 쉬었어요.", "나는 어제 일했어요."],
      "나는 어제 운동했어요.",
    ),
  ];

  int currentQuestionIndex = 0;
  List<String> selectedAnswers = [];

  void _submitAnswer(String answer) {
    selectedAnswers.add(answer);
    if (currentQuestionIndex < grammarQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _showResultScreen();
    }
  }

  void _showResultScreen() {
    int score = 0;
    for (int i = 0; i < grammarQuestions.length; i++) {
      if (selectedAnswers[i] == grammarQuestions[i].correctAnswer) {
        score++;
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          score: score,
          selectedAnswers: selectedAnswers,
          questions: grammarQuestions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = grammarQuestions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(title: const Text("Intermediate Grammar Quiz")),
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
