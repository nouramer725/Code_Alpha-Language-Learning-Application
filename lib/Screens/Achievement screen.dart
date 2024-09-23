import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AchievementScreen extends StatefulWidget {
  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  List<String> achievements = [];
  List<String> gameAchievements = [];
  List<String> quizAchievements = [];

  @override
  void initState() {
    super.initState();
    _loadAchievements();
  }

  // Method to load achievements from SharedPreferences
  Future<void> _loadAchievements() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      achievements = prefs.getStringList("achievements") ?? [];
      gameAchievements = prefs.getStringList("gameAchievements") ?? [];
      quizAchievements = prefs.getStringList("quizAchievements") ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: achievements.isNotEmpty || gameAchievements.isNotEmpty || quizAchievements.isNotEmpty
            ? ListView(
          children: [
            // Display for Game Achievements
            if (gameAchievements.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Game Achievements",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green[500]),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    shrinkWrap: true, // Required when nesting ListView inside ListView
                    physics: const NeverScrollableScrollPhysics(), // Prevents nested scrolling
                    itemCount: gameAchievements.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.green[100],
                        child: ListTile(
                          title: Text(gameAchievements[index]),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),

            // Display for Quiz Achievements
            if (achievements.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: const Text(
                      "Quiz Achievements",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.purple),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: achievements.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.purple[100],
                        child: ListTile(
                          title: Text(achievements[index]),
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        )
            : const Center(
          child: Text(
            "No achievements yet!",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
