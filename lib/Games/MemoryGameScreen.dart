import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoryGameScreen extends StatefulWidget {
  @override
  _MemoryGameScreenState createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  List<Map<String, String>> words = [
    {"김치": "Kimchi"},
    {"학교": "School"},
    {"사랑": "Love"},
    {"책": "Book"},
    {"의자": "Chair"},
    {"바다": "Sea"},
    {"하늘": "Sky"},
    {"컴퓨터": "Computer"},
    {"음악": "Music"},
    {"차": "Car"}
  ];

  List<String> shuffledWords = [];
  List<bool> revealed = [];
  int? firstIndex;
  int? secondIndex;

  @override
  void initState() {
    super.initState();
    _shuffleWords();
  }

  void _shuffleWords() {
    List<String> koreanWords = words.map((word) => word.keys.first).toList();
    List<String> englishWords = words.map((word) => word.values.first).toList();
    shuffledWords = koreanWords + englishWords;
    shuffledWords.shuffle();
    revealed = List.filled(shuffledWords.length, false);
  }

  void _handleCardTap(int index) {
    if (revealed[index] || (firstIndex != null && secondIndex != null)) return;

    setState(() {
      revealed[index] = true;
      if (firstIndex == null) {
        firstIndex = index;
      } else {
        secondIndex = index;
        _checkForMatch();
      }
    });
  }

  void _checkForMatch() async {
    if (firstIndex == null || secondIndex == null) return;

    String firstCard = shuffledWords[firstIndex!];
    String secondCard = shuffledWords[secondIndex!];

    bool isMatch = _isMatch(firstCard, secondCard);

    if (isMatch) {
      setState(() {
        firstIndex = null;
        secondIndex = null;
        if (revealed.every((r) => r)) {
          _showCompletionDialog();
        }
      });
    } else {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        revealed[firstIndex!] = false;
        revealed[secondIndex!] = false;
        firstIndex = null;
        secondIndex = null;
      });
    }
  }

  bool _isMatch(String firstCard, String secondCard) {
    for (var word in words) {
      if ((word.keys.first == firstCard && word.values.first == secondCard) ||
          (word.keys.first == secondCard && word.values.first == firstCard)) {
        return true;
      }
    }
    return false;
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Congratulations!"),
          content: const Text("You've matched all the words."),
          actions: <Widget>[
            TextButton(
              child: const Text("Okay"),
              onPressed: () async {
                await _saveAchievement();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveAchievement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> gameAchievements = prefs.getStringList("gameAchievements") ?? [];
    if (!gameAchievements.contains("Completed Memory Game")) {
      gameAchievements.add("Completed Memory Game");
      await prefs.setStringList("gameAchievements", gameAchievements);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Korean Memory Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: shuffledWords.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _handleCardTap(index),
              child: Card(
                elevation: 25,
                color: revealed[index] ? Colors.blue[100] : Colors.blue,
                child: Center(
                  child: Text(
                    revealed[index] ? shuffledWords[index] : "?",
                    style: const TextStyle(fontSize: 21),
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
