import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class KoreanMatchingGameScreen extends StatefulWidget {
  @override
  _KoreanMatchingGameScreenState createState() => _KoreanMatchingGameScreenState();
}

class _KoreanMatchingGameScreenState extends State<KoreanMatchingGameScreen> {
  List<String> characters = ["ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ"];
  List<String> sounds = ["giyeok", "nieun", "digeut", "rieul", "mieum"];
  List<String> cards = [];
  List<bool> flipped = [];
  int? firstIndex;
  int? secondIndex;

  @override
  void initState() {
    super.initState();
    cards = characters + sounds;
    cards.shuffle();
    flipped = List<bool>.filled(cards.length, false);
  }

  void _handleCardTap(int index) {
    if (flipped[index] || (firstIndex != null && secondIndex != null)) return;

    setState(() {
      flipped[index] = true;

      if (firstIndex == null) {
        firstIndex = index;
      } else if (secondIndex == null) {
        secondIndex = index;
        _checkForMatch();
      }
    });
  }

  void _checkForMatch() async {
    if (firstIndex == null || secondIndex == null) return;

    String firstCard = cards[firstIndex!];
    String secondCard = cards[secondIndex!];

    if (_isMatch(firstCard, secondCard)) {
      setState(() {
        firstIndex = null;
        secondIndex = null;
        if (flipped.every((element) => element)) {
          _showCompletionDialog();
        }
      });
    } else {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        flipped[firstIndex!] = false;
        flipped[secondIndex!] = false;
        firstIndex = null;
        secondIndex = null;
      });
    }
  }

  bool _isMatch(String firstCard, String secondCard) {
    int firstIndex = characters.indexOf(firstCard);
    int secondIndex = sounds.indexOf(secondCard);
    return firstIndex != -1 && secondIndex != -1 && firstIndex == secondIndex;
  }

  Future<void> _saveGameAchievement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> gameAchievements = prefs.getStringList("gameAchievements") ?? [];
    if (!gameAchievements.contains("Completed Matching Game")) {
      gameAchievements.add("Matching Game Completed🎉");
      await prefs.setStringList("gameAchievements", gameAchievements);
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Congratulations!"),
          content: const Text("You've matched all the characters."),
          actions: <Widget>[
            TextButton(
              child: const Text("Okay"),
              onPressed: () async {
                await _saveGameAchievement(); // Save the achievement
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Korean Character Matching Game')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _handleCardTap(index),
              child: Card(
                color: flipped[index] ? Colors.blue[100] : Colors.blue,
                child: Center(
                  child: Text(
                    flipped[index] ? cards[index] : "?",
                    style: TextStyle(
                      fontSize: 21,
                      color: flipped[index] ? Colors.black : Colors.white,
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
