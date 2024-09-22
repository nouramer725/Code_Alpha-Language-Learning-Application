import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ResultScreen.dart';
import 'VowelsQuizScreen.dart'; // Ensure this path is correct

class PastFutureEventsQuizScreen extends StatefulWidget {
  @override
  _PastFutureEventsQuizScreenState createState() => _PastFutureEventsQuizScreenState();
}

class _PastFutureEventsQuizScreenState extends State<PastFutureEventsQuizScreen> {
  final List<Question> eventQuestions = [
    // Past events (Korean to English)
    Question("-았/었: 나는 어제 운동했어요.", ["I exercised yesterday.", "I will exercise tomorrow.", "I am exercising now.", "I used to exercise."], "I exercised yesterday."),
    Question("-았/었: 우리는 지난주에 만났어요.", ["We met last week.", "We are meeting today.", "We will meet next week.", "We used to meet."], "We met last week."),
    Question("-았/었: 저는 작년에 이사했어요.", ["I moved last year.", "I will move next year.", "I am moving soon.", "I think I will move."], "I moved last year."),
    Question("-았/었: 그들은 어제 영화를 봤어요.", ["They watched a movie yesterday.", "They are watching a movie now.", "They will watch a movie tomorrow.", "They like watching movies."], "They watched a movie yesterday."),
    Question("-았/었: 그는 지난 주말에 일을 했어요.", ["He worked last weekend.", "He will work next weekend.", "He is working today.", "He used to work."], "He worked last weekend."),
    // Future events (English to Korean)
    Question("I will go shopping tomorrow.", ["내일 쇼핑할 거예요.", "내일 쇼핑했어요.", "내일 쇼핑하고 있어요.", "내일 쇼핑했을 거예요."], "내일 쇼핑할 거예요."),
    Question("We will travel next month.", ["우리는 다음 달에 여행할 거예요.", "우리는 지난달에 여행했어요.", "우리는 이번 달에 여행하고 있어요.", "우리는 여행할 예정이에요."], "우리는 다음 달에 여행할 거예요."),
    Question("They will move to a new house next year.", ["그들은 내년에 새 집으로 이사할 거예요.", "그들은 작년에 새 집으로 이사했어요.", "그들은 지금 새 집으로 이사하고 있어요.", "그들은 이사할 예정이에요."], "그들은 내년에 새 집으로 이사할 거예요."),
    Question("He will start a new job next week.", ["그는 다음 주에 새 일을 시작할 거예요.", "그는 지난 주에 새 일을 시작했어요.", "그는 이번 주에 새 일을 시작할 거예요.", "그는 새 일을 하고 있어요."], "그는 다음 주에 새 일을 시작할 거예요."),
    Question("We will meet tomorrow.", ["우리는 내일 만날 거예요.", "우리는 어제 만났어요.", "우리는 오늘 만나요.", "우리는 만날 예정이에요."], "우리는 내일 만날 거예요."),
  ];

  int currentQuestionIndex = 0;
  List<String> selectedAnswers = [];

  void _submitAnswer(String answer) {
    selectedAnswers.add(answer);
    if (currentQuestionIndex < eventQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _showCompletionDialog("Past and Future Events Quiz Completed🎉");
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
    for (int i = 0; i < eventQuestions.length; i++) {
      if (selectedAnswers[i] == eventQuestions[i].correctAnswer) {
        score++;
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          score: score,
          selectedAnswers: selectedAnswers,
          questions: eventQuestions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = eventQuestions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(title: const Text("Past and Future Events Quiz")),
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