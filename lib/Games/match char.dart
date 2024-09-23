import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatchingChar extends StatefulWidget {
  @override
  _MatchingCharState createState() => _MatchingCharState();
}

class _MatchingCharState extends State<MatchingChar> {
  // Sample data
  final Map<String, String> Matching = {

// Vowels (한글 모음)
    "ㅏ": "A",
    "ㅑ": "Ya",
    "ㅓ": "Eo",
    "ㅕ": "Yeo",
    "ㅗ": "O",
    "ㅛ": "Yo",
    "ㅜ": "U",
    "ㅠ": "Yu",

// Characters (한글 자모)
    "ㄱ": "G",
    "ㄴ": "N",
    "ㄷ": "D",
    "ㄹ": "R/L",
    "ㅁ": "M",
    "ㅂ": "B",
    "ㅅ": "S",
    "ㅇ": "Silent/Ng",

// Consonants (한글 자음)
    "ㄱ": "G/K",
    "ㄲ": "KK",
    "ㄴ": "N",
    "ㄷ": "D",
    "ㄸ": "TT",
    "ㅁ": "M",
    "ㅂ": "B",
    "ㅃ": "PP",

  };

  List<String> korean = [];
  List<String> english = [];
  int? selectedKoreanIndex;
  int? selectedEnglishIndex;
  int score = 0; // Initialize score to 0

  @override
  void initState() {
    super.initState();
    korean = Matching.keys.toList();
    english = Matching.values.toList();
    english.shuffle(); // Shuffle the English list for randomness
  }

  Future<void> _saveAchievement(String achievement) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> achievements = prefs.getStringList("achievements") ?? [];
    if (!achievements.contains(achievement)) {
      achievements.add(achievement);
      await prefs.setStringList("achievements", achievements);
    }
  }

  // Method to handle selection
  void _selectKorean(int index) {
    setState(() {
      selectedKoreanIndex = index;
      if (selectedEnglishIndex != null) {
        _checkMatch();
      }
    });
  }

  void _selectEnglish(int index) {
    setState(() {
      selectedEnglishIndex = index;
      if (selectedKoreanIndex != null) {
        _checkMatch();
      }
    });
  }

  // Check if the selected items match
  void _checkMatch() {
    if (Matching[korean[selectedKoreanIndex!]] ==
        english[selectedEnglishIndex!]) {
      setState(() {
        score++; // Increment score when the match is correct
      });
      _showDialogOkay("Correct! Congratulations!! 🥳");
    } else {
      _showDialog("Wrong match! Try Again 😭");
    }
  }

  // Show feedback dialog for correct match
  void _showDialogOkay(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.green),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _nextMatch();
            },
            child: const Text("Next"),
          )
        ],
      ),
    );
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.red),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                selectedKoreanIndex = null;
                selectedEnglishIndex = null;
              });
            },
            child: const Text("Try Again"),
          )
        ],
      ),
    );
  }

  // Move to the next match
  void _nextMatch() {
    setState(() {
      if (korean.isNotEmpty) {
        korean.removeAt(selectedKoreanIndex!);
        english.removeAt(selectedEnglishIndex!);
        selectedKoreanIndex = null;
        selectedEnglishIndex = null;
        english.shuffle();
      }

      // Check if the game is complete
      if (korean.isEmpty) {
        _showCompletionDialog();
      }
    });
  }

  // Show the completion dialog
  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "WOW! 🎉",
          style: TextStyle(color: Colors.green),
        ),
        content: Text(
          "You've completed all the matches with a score of $score.",
          style: TextStyle(color: Colors.green),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await _saveAchievement("Completed Food Matching Game");
              Navigator.of(context).pop();
            },
            child: const Text("Okay"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Center(
              child: const Text(
                "Match the Korean food with its English translation:",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Score: $score", // Display the current score
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(korean.length, (index) {
                          return _buildFoodTile(
                            korean[index],
                            selectedKoreanIndex == index,
                                () => _selectKorean(index),
                          );
                        }),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(english.length, (index) {
                          return _buildFoodTile(
                            english[index],
                            selectedEnglishIndex == index,
                                () => _selectEnglish(index),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodTile(String food, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.red[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.black,
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          food,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
