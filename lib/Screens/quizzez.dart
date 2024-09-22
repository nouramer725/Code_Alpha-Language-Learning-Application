import 'package:flutter/material.dart';
import 'package:learning/Quizez/CharactersQuiz.dart';
import 'package:learning/Quizez/INtermidateQuiz.dart';
import 'package:learning/Quizez/PastQuiz.dart';
import 'package:learning/Quizez/VowelsQuizScreen.dart';
import '../Quizez/ConsonantsQuizScreen.dart';
import '../Quizez/FamilyQuizScreen.dart';
import '../Quizez/FoodQuizScreen.dart';
import '../Quizez/GreetingsQuizScreen.dart';
import '../Quizez/IntroduceYourselfQuizScreen.dart';
import '../Quizez/SentencesQuizScreen.dart';
import '../Quizez/VerbsQuizScreen.dart';

class QuizHomePage extends StatelessWidget {
  final List<String> beginnerQuizTitles = [
    "Vowels Quiz",
    "Consonants Quiz",
    "Characters Quiz",
    "Sentences Quiz",
  ];

  final List<Widget> beginnerQuizScreens = [
    VowelsQuizScreen(),
    ConsonantsQuizScreen(),
    KoreanCharactersAdditionQuizScreen(),
    SentenceQuizScreen(),
  ];

  final List<String> intermediateQuizTitles = [
    "Food Quiz",
    "Family Quiz",
    "Verbs Quiz",
    "Past and Future Event",
    "Intermediate Grammar",
  ];

  final List<Widget> intermediateQuizScreens = [
    FoodQuizScreen(),
    FamilyMembersQuizScreen(),
    VerbsQuizScreen(),
    PastFutureEventsQuizScreen(),
    IntermediateGrammarQuizScreen(),
  ];

  final List<String> advancedQuizTitles = [
    "Introduce Yourself Quiz",
    "Greetings Quiz",
  ];

  final List<Widget> advancedQuizScreens = [
    IntroduceYourselfQuizScreen(),
    GreetingQuizScreen(),
  ];

  // Navigate to quiz screen
  void _navigateToQuiz(BuildContext context, int index, List<Widget> screens) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screens[index],
      ),
    );
  }

  // Builds a scrollable row of quizzes
  Widget buildQuizRow(
      BuildContext context, List<String> quizTitles, List<Widget> quizScreens) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(quizTitles.length, (index) {
          return GestureDetector(
            onTap: () => _navigateToQuiz(context, index, quizScreens),
            child: Card(
              elevation: 40,
              color: Colors.blue[200],
              shape: const BorderDirectional(
                end: BorderSide(width: 3, color: Colors.black12),
              ),
              child: Container(
                width: 150,
                height: 130,
                child: Center(
                  child: Text(
                    quizTitles[index],
                    style: const TextStyle(fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Quiz Home Page",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Beginner",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            buildQuizRow(context, beginnerQuizTitles, beginnerQuizScreens),
            const SizedBox(height: 20),
            const Text(
              "Intermediate",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            buildQuizRow(context, intermediateQuizTitles, intermediateQuizScreens),
            const SizedBox(height: 20),
            const Text(
              "Advanced",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            buildQuizRow(context, advancedQuizTitles, advancedQuizScreens),
          ],
        ),
      ),
    );
  }
}
