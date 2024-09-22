import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AchievementScreen extends StatefulWidget {
  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  List<String> achievements = [];

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Achievements"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: achievements.isNotEmpty
            ? ListView.builder(
          itemCount: achievements.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.green,
              child: ListTile(
                title: Text(achievements[index]),
              ),
            );
          },
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
