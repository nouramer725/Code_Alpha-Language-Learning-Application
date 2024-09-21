import 'package:flutter/material.dart';
import 'package:learning/widgets/beginner/Consonants.dart';
import 'package:learning/widgets/intermidiate/Intermediate%20Grammar%20Screen.dart';
import 'package:learning/widgets/beginner/Vowles.dart';
import 'package:learning/widgets/intermidiate/family.dart';
import 'package:learning/widgets/intermidiate/food.dart';
import 'package:learning/widgets/advanced/introduce%20yourself.dart';
import 'package:learning/widgets/intermidiate/verbs.dart';
import '../widgets/beginner/Basic sentences.dart';
import '../widgets/beginner/Characters.dart';
import '../widgets/advanced/Greet_people.dart';
import '../widgets/intermidiate/Past Events and Future Plans Screen.dart';

class LanguagesScreen extends StatelessWidget {
  // Categories divided into three levels
  final List<String> beginnerTitles = [
    "Learn Korean Vowels",
    "Learn Korean Consonants",
    "Learn Korean Characters",
    "Learn Basic Sentences",
  ];

  final List<String> intermediateTitles = [
    "Talk about Food",
    "Family Members",
    "Learn Basic Verbs",
    "Past Events and Future Plans",
    "Intermediate Grammar"
  ];

  final List<String> advancedTitles = [
    "Introduce Yourself",
    "Greet People",
  ];

  final List<Widget> beginnerScreens = [
    KoreanVowelsScreen(),
    KoreanConsonantsScreen(),
    KoreanMatrixScreen(),
    KoreanSentencesScreen(),
  ];

  final List<Widget> intermediateScreens = [
    KoreanFoodScreen(),
    FamilyMembersScreen(),
    VerbsScreen(),
    PastFuturePlansScreen(),
    IntermediateGrammarScreen()
  ];

  final List<Widget> advancedScreens = [
    IntroduceYourselfScreen(),
    GreetPeopleScreen(),
  ];

  final List<String> imagePaths = [
    'assets/images/image1.png',
    'assets/images/image1.png',
    'assets/images/image1.png',
    'assets/images/image1.png',
    'assets/images/image1.png',
    'assets/images/image1.png',
    'assets/images/image1.png',
    'assets/images/image1.png',
    'assets/images/image1.png',
  ];

  // Navigate to different screens when the container is clicked
  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  Widget _buildLevelSection(BuildContext context, String levelTitle,
      List<String> titles, List<Widget> screens, List<String> imagePaths) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadiusDirectional.circular(10),
            ),
            child: Text(
              levelTitle,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () => _navigateToScreen(context, screens[index]),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePaths[index]),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              titles[index],
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Learn More',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Beginner Level
            _buildLevelSection(context, "  Beginner  ", beginnerTitles,
                beginnerScreens, imagePaths.sublist(0, 4)),
            // Intermediate Level
            _buildLevelSection(context, "  Intermediate  ", intermediateTitles,
                intermediateScreens, imagePaths.sublist(2, 7)),
            // Advanced Level
            _buildLevelSection(context, "  Advanced  ", advancedTitles,
                advancedScreens, imagePaths.sublist(7, 9)),
            // Fix here: Ensure sublist doesn't go out of range
          ],
        ),
      ),
    );
  }
}