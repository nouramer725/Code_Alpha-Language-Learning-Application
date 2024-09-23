import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrueFalseGameScreen extends StatefulWidget {
  @override
  _TrueFalseGameScreenState createState() => _TrueFalseGameScreenState();
}

class _TrueFalseGameScreenState extends State<TrueFalseGameScreen> {
  final List<Map<String, dynamic>> statements = [
    {"statement": "The word '밥' means food.", "isTrue": true},
    {"statement": "Korean has no alphabet.", "isTrue": false},
    {"statement": "The capital of South Korea is Seoul.", "isTrue": true},
    {"statement": "Kimchi is a type of soup.", "isTrue": false},
    {"statement": "Hangul is the alphabet used in Korea.", "isTrue": true},
  {"statement": "The word '밥' means food.", "isTrue": true},
  {"statement": "Korean has no alphabet.", "isTrue": false},
  {"statement": "The capital of South Korea is Seoul.", "isTrue": true},
  {"statement": "Kimchi is a type of soup.", "isTrue": false},
  {"statement": "Hangul is the alphabet used in Korea.", "isTrue": true},
  {"statement": "The word '안녕하세요' means 'Hello'.", "isTrue": true},
  {"statement": "Korean uses the Latin alphabet.", "isTrue": false},
  {"statement": "The phrase '감사합니다' means 'Thank you'.", "isTrue": true},
  {"statement": "Korean is a tonal language.", "isTrue": false},
  {"statement": "The word '안녕히 가세요' is used when someone is leaving.", "isTrue": true},
  {"statement": "In Korea, it's polite to bow when greeting someone.", "isTrue": true},
  {"statement": "The phrase '죄송합니다' means 'I'm sorry'.", "isTrue": true},
  {"statement": "Korean sentences always start with the subject.", "isTrue": false},
  {"statement": "The word '여보세요' is used when answering the phone.", "isTrue": true},
  {"statement": "Korean grammar is similar to English grammar.", "isTrue": false},
  {"statement": "The phrase '잘 지내세요?' means 'How are you?'.", "isTrue": true},
  {"statement": "The word '사랑' means 'love'.", "isTrue": true},
];

  List<bool?> userAnswers =[]; // Store user answers
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    userAnswers = List<bool?>.filled(statements.length, null); // Initialize answers
  }

  void _submitAnswers() {
    int score = 0;
    for (int i = 0; i < statements.length; i++) {
      if (userAnswers[i] == statements[i]['isTrue']) {
        score++;
      }
    }
    setState(() {
      isCompleted = true; // Mark the game as completed
    });
    _showCompletionDialog(score);
  }

  void _showCompletionDialog(int score) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Congratulations!"),
          content: Text("You've completed the True or False Game. Score: $score/${statements.length}"),
          actions: <Widget>[
            TextButton(
              child: const Text("Okay"),
              onPressed: () {
                _saveAchievement("Completed True or False Game");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveAchievement(String achievement) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> achievements = prefs.getStringList("gameAchievements") ?? [];
    achievements.add(achievement);
    await prefs.setStringList("gameAchievements", achievements);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("True or False Game")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: statements.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(statements[index]['statement']),
                        subtitle: isCompleted
                            ? Icon(
                          statements[index]['isTrue'] == true
                              ? Icons.check
                              : Icons.close,
                          color: statements[index]['isTrue'] == true
                              ? Colors.green
                              : Colors.red,
                        )
                            : null,
                        trailing: isCompleted
                            ? null
                            : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<bool>(
                              value: true,
                              groupValue: userAnswers[index],
                              onChanged: (value) {
                                setState(() {
                                  userAnswers[index] = value;
                                });
                              },
                            ),
                            const Text("True"),
                            Radio<bool>(
                              value: false,
                              groupValue: userAnswers[index],
                              onChanged: (value) {
                                setState(() {
                                  userAnswers[index] = value;
                                });
                              },
                            ),
                            const Text("False"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (!isCompleted)
                ElevatedButton(
                  onPressed: _submitAnswers,
                  child: const Text("Submit Answers",style: TextStyle(
                    color: Colors.blue,
                  ),),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
