import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:learning/widgets/beginner/Consonants.dart';
import 'package:learning/widgets/intermidiate/Intermediate Grammar Screen.dart';
import 'package:learning/widgets/beginner/Vowles.dart';
import 'package:learning/widgets/intermidiate/family.dart';
import 'package:learning/widgets/intermidiate/food.dart';
import 'package:learning/widgets/advanced/introduce yourself.dart';
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
    'assets/images/vowels.jpg',
    'assets/images/consta.jpg',
    'assets/images/char.jpg',
    'assets/images/sentence.jpg',
    'assets/images/fooddd.jpg',
    'assets/images/Familyyy.jpg',
    'assets/images/verbsss.jpg',
    'assets/images/future.jpg',
    'assets/images/gramm.jpeg',
    'assets/images/introoo.jpg',
    'assets/images/greett.jpg',
  ];

  final List<String> youtubeLinks = [
    "https://youtu.be/4CJ8GkKSR_E?si=PwmlnBOc3Q6WoJpY", // Vowels
    "https://youtu.be/1A5YQ0H5dZg?si=Tbe1UreCnoiukA8L", // Consonants
    "https://youtu.be/6jdX2qOkU5M?si=mP_bkFxjYLTpoYiB", // Characters
    "https://youtu.be/TUSNTV7VkcI?si=BayCLJiVhcNLXSAk", // Basic Sentences
    "https://youtu.be/VfekBGYRx0o?si=96Z6GkWqWz9v7__A", // Food
    "https://youtu.be/rKPz5E9P-30?si=orZaOcEllPf-2iLT", // Family Members
    "https://youtu.be/K7dgMVKPTHw?si=q_Uoc8lEZMckIDZ-", // Basic Verbs
    "https://youtu.be/aNJ_18Y5FVE?si=gx1CauBN7b4mcOBE", // Past and Future Plans
    "https://www.youtube.com/playlist?list=PL6D-YTosvGYoafH6RdvZrAc5iURh6gJ51", // Intermediate Grammar
    "https://youtu.be/hUSU4WQguTw?si=5llDZELNHzUZtK5P", // Introduce Yourself
    "https://youtu.be/RzQQAs_PuZw?si=slDO1mJFNPrTPmPp"  // Greet People
  ];


  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


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
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () => _navigateToScreen(context, screens[index]),
                child: Container(
                  height: 200,
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
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              titles[index],
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () => _launchURL(youtubeLinks[index]),
                              child: Container(
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
                            ),
                            ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(Colors.black12)
                              ),
                              onPressed: () => _navigateToScreen(context, screens[index]),
                              child: const Text('Start',style: TextStyle(
                                color: Colors.white
                              ),
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
                intermediateScreens, imagePaths.sublist(4, 9)),
            // Advanced Level
            _buildLevelSection(context, "  Advanced  ", advancedTitles,
                advancedScreens, imagePaths.sublist(9, 11)),
          ],
        ),
      ),
    );
  }
}
