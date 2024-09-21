import 'package:flutter/material.dart';
import 'package:learning/Quizez/VowelsQuizScreen.dart';
import '../Quizez/ConsonantsQuizScreen.dart';
import '../Quizez/FamilyQuizScreen.dart';
import '../Quizez/FoodQuizScreen.dart';
import '../Quizez/GreetingsQuizScreen.dart';
import '../Quizez/IntroduceYourselfQuizScreen.dart';
import '../Quizez/SentencesQuizScreen.dart';
import '../Quizez/VerbsQuizScreen.dart';

class QuizHomePage extends StatelessWidget {
  final List<String> quizTitles = [
    "Vowels Quiz",
    "Consonants Quiz",
    "Sentences Quiz",
    "Greetings Quiz",
    "Family Quiz",
    "Introduce Yourself Quiz",
    "Food Quiz",
    "Verbs Quiz",
  ];

  final List<Widget> quizScreens = [
    VowelsQuizScreen(),
    ConsonantsQuizScreen(),
    SentenceQuizScreen(),
    GreetingQuizScreen(),
    FamilyMembersQuizScreen(),
    IntroduceYourselfQuizScreen(),
    FoodQuizScreen(),
    VerbsQuizScreen(),
  ];

  // Navigate to quiz screen
  void _navigateToQuiz(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => quizScreens[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: quizTitles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _navigateToQuiz(context, index),
              child: Card(
                elevation: 40,
                color: Colors.redAccent[100],
                shape: BorderDirectional(
                  end: BorderSide(
                    width: 3,
                    color: Colors.black12
                  )
                ),
                child: Center(
                  child: Text(
                    quizTitles[index],
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
