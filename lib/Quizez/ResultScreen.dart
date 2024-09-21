import 'package:flutter/material.dart';

import '../Quizez/VowelsQuizScreen.dart';

class ResultsScreen extends StatelessWidget {
  final int score;
  final List<String> selectedAnswers;
  final List<Question> questions;

  ResultsScreen({
    required this.score,
    required this.selectedAnswers,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz Results")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("You scored $score out of ${questions.length}", style: TextStyle(color:Colors.pink[500],fontSize: 28))),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final question = questions[index];
                    final userAnswer = selectedAnswers[index];
                    final isCorrect = userAnswer == question.correctAnswer;

                    return ListTile(
                      title: Text(question.questionText),
                      subtitle: Text(
                        "Your answer: $userAnswer\nCorrect answer: ${question.correctAnswer}",
                        style: TextStyle(color: isCorrect ? Colors.green : Colors.red),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
