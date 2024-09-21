import 'package:flutter/material.dart';
import 'dart:math';

class GamifiedLearningScreen extends StatefulWidget {
  @override
  _GamifiedLearningScreenState createState() => _GamifiedLearningScreenState();
}

class _GamifiedLearningScreenState extends State<GamifiedLearningScreen> {
  int _score = 0;
  int _level = 1;
  int _pointsToNextLevel = 10;
  int _currentCategoryIndex = 0;
  int _correctAnswersInCategory = 0;
  final int _questionsNeededForLevelUp = 10;

  // Define categories with sample questions
  final List<List<Question>> _categories = [
    // Vowels
    [
      Question("What is the vowel sound for 'ㅏ'?", ["a", "e", "i", "o"], "a"),
      Question("What is the vowel sound for 'ㅑ'?", ["ya", "ye", "yu", "o"], "ya"),
      Question("What is the vowel sound for 'ㅐ'?", ["ae", "e", "i", "o"], "ae"),
      Question("What is the vowel sound for 'ㅔ'?", ["e", "ae", "i", "o"], "e"),
      Question("What is the vowel sound for 'ㅗ'?", ["o", "u", "e", "i"], "o"),
      Question("What is the vowel sound for 'ㅛ'?", ["yo", "yu", "ae", "o"], "yo"),
      Question("What is the vowel sound for 'ㅜ'?", ["u", "o", "i", "ae"], "u"),
      Question("What is the vowel sound for 'ㅠ'?", ["yu", "u", "o", "i"], "yu"),
      Question("What is the vowel sound for 'ㅡ'?", ["eu", "u", "o", "i"], "eu"),
      Question("What is the vowel sound for 'ㅣ'?", ["i", "e", "a", "o"], "i"),
    ],
    [
      Question("What is the consonant sound for 'ㄱ'?", ["g", "k", "d", "b"], "g"),
      Question("What is the consonant sound for 'ㄴ'?", ["n", "m", "l", "r"], "n"),
      Question("What is the consonant sound for 'ㄷ'?", ["d", "t", "g", "b"], "d"),
      Question("What is the consonant sound for 'ㄹ'?", ["r", "l", "n", "m"], "r"),
      Question("What is the consonant sound for 'ㅁ'?", ["m", "n", "b", "p"], "m"),
      Question("What is the consonant sound for 'ㅂ'?", ["b", "p", "m", "d"], "b"),
      Question("What is the consonant sound for 'ㅅ'?", ["s", "t", "k", "d"], "s"),
      Question("What is the consonant sound for 'ㅇ'?", ["ng", "n", "m", "r"], "ng"),
      Question("What is the consonant sound for 'ㅈ'?", ["j", "t", "g", "d"], "j"),
      Question("What is the consonant sound for 'ㅊ'?", ["ch", "t", "k", "s"], "ch"),
    ],
    // Basic Sentences
    [
      Question("How do you say 'hello' in Korean?", ["안녕하세요", "안녕히 가세요", "감사합니다", "미안합니다"], "안녕하세요"),
      Question("What is 'thank you' in Korean?", ["안녕하세요", "안녕히 가세요", "감사합니다", "미안합니다"], "감사합니다"),
      Question("How do you say 'goodbye' in Korean?", ["안녕하세요", "안녕히 가세요", "감사합니다", "미안합니다"], "안녕히 가세요"),
      Question("What is 'I'm sorry' in Korean?", ["안녕하세요", "안녕히 가세요", "감사합니다", "미안합니다"], "미안합니다"),
      Question("How do you say 'yes' in Korean?", ["네", "아니요", "응", "감사합니다"], "네"),
      Question("What is 'no' in Korean?", ["네", "아니요", "응", "감사합니다"], "아니요"),
      Question("How do you say 'please' in Korean?", ["부탁합니다", "감사합니다", "미안합니다", "안녕하세요"], "부탁합니다"),
      Question("What is 'good morning' in Korean?", ["좋은 아침입니다", "안녕하세요", "안녕히 가세요", "감사합니다"], "좋은 아침입니다"),
      Question("How do you say 'see you later' in Korean?", ["또 봐요", "안녕하세요", "안녕히 가세요", "감사합니다"], "또 봐요"),
      Question("What is 'welcome' in Korean?", ["환영합니다", "안녕하세요", "감사합니다", "미안합니다"], "환영합니다"),
    ],
    // Greeting People
    [
      Question("What do you say when meeting someone?", ["안녕하세요", "잘 가세요", "고맙습니다", "미안합니다"], "안녕하세요"),
      Question("How do you greet someone in the morning?", ["안녕하세요", "좋은 아침입니다", "안녕히 주무세요", "감사합니다"], "좋은 아침입니다"),
      Question("What do you say when parting ways?", ["안녕하세요", "잘 가세요", "고맙습니다", "미안합니다"], "잘 가세요"),
      Question("How do you express gratitude?", ["안녕하세요", "고맙습니다", "미안합니다", "안녕히 가세요"], "고맙습니다"),
      Question("What do you say when apologizing?", ["미안합니다", "안녕하세요", "감사합니다", "잘 가세요"], "미안합니다"),
      Question("How do you say 'nice to meet you'?", ["반갑습니다", "고맙습니다", "안녕하세요", "안녕히 가세요"], "반갑습니다"),
      Question("What phrase do you use to welcome someone?", ["환영합니다", "안녕하세요", "고맙습니다", "미안합니다"], "환영합니다"),
      Question("How do you say 'take care' when parting?", ["안녕하세요", "잘 가세요", "감사합니다", "미안합니다"], "잘 가세요"),
      Question("What do you say when asking how someone is?", ["안녕하세요", "어떻게 지내세요?", "잘 가세요", "고맙습니다"], "어떻게 지내세요?"),
      Question("How do you respond to 'thank you'?", ["괜찮아요", "고맙습니다", "미안합니다", "안녕하세요"], "괜찮아요"),
    ],
    // Family Members
    [
      Question("What is 'mother' in Korean?", ["어머니", "아버지", "형", "누나"], "어머니"),
      Question("What is 'father' in Korean?", ["어머니", "아버지", "형", "누나"], "아버지"),
      Question("What is 'older brother' in Korean?", ["형", "오빠", "동생", "누나"], "형"),
      Question("What is 'younger sister' in Korean?", ["언니", "누나", "동생", "여동생"], "여동생"),
      Question("What is 'older sister' in Korean?", ["누나", "언니", "여동생", "형"], "언니"),
      Question("What is 'younger brother' in Korean?", ["형", "동생", "오빠", "아버지"], "동생"),
      Question("What is 'grandfather' in Korean?", ["할아버지", "할머니", "아버지", "어머니"], "할아버지"),
      Question("What is 'grandmother' in Korean?", ["할머니", "할아버지", "엄마", "아빠"], "할머니"),
      Question("What is 'uncle' in Korean?", ["삼촌", "이모", "고모", "아빠"], "삼촌"),
      Question("What is 'aunt' in Korean?", ["이모", "고모", "삼촌", "엄마"], "이모"),
    ],
    // Introduce Yourself
    [
      Question("How do you say 'My name is' in Korean?", ["저는", "나는", "그는", "그녀는"], "저는"),
      Question("How do you say 'I am a student' in Korean?", ["나는 학생입니다", "저는 학생입니다", "그는 학생입니다", "그녀는 학생입니다"], "저는 학생입니다"),
      Question("What does '저는 한국인입니다' mean?", ["I am American", "I am Korean", "I am Japanese", "I am Chinese"], "I am Korean"),
      Question("How do you say 'I am from Egypt' in Korean?", ["나는 이집트에서 왔어요", "저는 이집트에서 왔어요", "그는 이집트에서 왔어요", "그녀는 이집트에서 왔어요"], "저는 이집트에서 왔어요"),
      Question("How do you say 'Nice to meet you' in Korean?", ["안녕하세요", "만나서 반갑습니다", "고맙습니다", "잘 가세요"], "만나서 반갑습니다"),
      Question("How do you say 'I am 20 years old' in Korean?", ["나는 20살이에요", "저는 20살이에요", "그는 20살이에요", "그녀는 20살이에요"], "저는 20살이에요"),
      Question("How do you say 'This is my friend' in Korean?", ["이것은 내 친구입니다", "저는 내 친구입니다", "그는 내 친구입니다", "그녀는 내 친구입니다"], "이것은 내 친구입니다"),
      Question("How do you say 'I like to learn Korean' in Korean?", ["나는 한국어 배우는 것을 좋아해요", "저는 한국어 배우는 것을 좋아해요", "그는 한국어 배우는 것을 좋아해요", "그녀는 한국어 배우는 것을 좋아해요"], "저는 한국어 배우는 것을 좋아해요"),
      Question("How do you say 'I live in Cairo' in Korean?", ["나는 카이로에 살아요", "저는 카이로에 살아요", "그는 카이로에 살아요", "그녀는 카이로에 살아요"], "저는 카이로에 살아요"),
      Question("How do you say 'I am happy' in Korean?", ["나는 행복해요", "저는 행복해요", "그는 행복해요", "그녀는 행복해요"], "저는 행복해요"),
    ],
    // Food
    [
      Question("What is 'rice' in Korean?", ["밥", "국", "김치", "과일"], "밥"),
      Question("What is 'kimchi' in Korean?", ["국", "김치", "밥", "과일"], "김치"),
      Question("What is 'soup' in Korean?", ["국", "김치", "밥", "과일"], "국"),
      Question("What is 'fruit' in Korean?", ["밥", "국", "김치", "과일"], "과일"),
      Question("What is 'meat' in Korean?", ["고기", "밥", "국", "김치"], "고기"),
      Question("What is 'vegetable' in Korean?", ["채소", "과일", "밥", "김치"], "채소"),
      Question("What is 'noodle' in Korean?", ["면", "밥", "국", "김치"], "면"),
      Question("What is 'fish' in Korean?", ["생선", "고기", "국", "김치"], "생선"),
      Question("What is 'salad' in Korean?", ["샐러드", "밥", "국", "김치"], "샐러드"),
      Question("What is 'dessert' in Korean?", ["디저트", "밥", "국", "김치"], "디저트"),
    ],
  ];

  void _incrementScore() {
    setState(() {
      _score++;
      _correctAnswersInCategory++;
      if (_correctAnswersInCategory >= _questionsNeededForLevelUp) {
        _level++;
        _pointsToNextLevel += 5; // Increase points needed for next level

        // Check if the new level is 8 and show the congratulations dialog
        if (_level == 8) {
          _showCongratulationsDialog();
        }
        _resetCategory();
      }
    });
  }

  void _resetCategory() {
    setState(() {
      _currentCategoryIndex = (_currentCategoryIndex + 1) % _categories.length;
      _correctAnswersInCategory = 0;
      _score = 0; // Reset score for the new category
    });
  }

  void _resetGame() {
    setState(() {
      _score = 0;
      _level = 1;
      _pointsToNextLevel = 5;
      _currentCategoryIndex = 0;
      _correctAnswersInCategory = 0;
    });
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Center(
            child: const Text('Congratulations!', style: TextStyle(fontSize: 24, color: Colors.green)),
          ),
          content: const Text('You have reached Level 8! Great job!', style: TextStyle(fontSize: 16)),
          actions: [
            TextButton(
              onPressed: () {
                _resetGame();
                Navigator.of(ctx).pop(); // Close the dialog
              },
              child: const Text('OK', style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }


  void _checkAnswer(String answer, String correctAnswer) {
    if (answer == correctAnswer) {
      _incrementScore();
    } else {
      // Show alert dialog for incorrect answer
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Center(
              child: const Text('Incorrect Answer',style: TextStyle(fontSize: 20,color: Colors.red),
              ),
            ),
            content: const Text('That answer is not correct. Please try again!',style: TextStyle(fontSize: 15),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(); // Close the dialog
                },
                child: const Text('OK',style: TextStyle(fontSize: 15,color: Colors.red),
                ),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final currentCategory = _categories[_currentCategoryIndex];
    final question = currentCategory[Random().nextInt(currentCategory.length)];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gamified Learning Experience'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetGame,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Score: $_score',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Level: $_level',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: _score / _pointsToNextLevel,
              backgroundColor: Colors.grey[500],
              color: Colors.redAccent,
            ),
            const SizedBox(height: 20),
            Text(
              question.questionText,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ...question.options.map((option) {
              return ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
                  overlayColor: WidgetStatePropertyAll(Colors.redAccent)
                ),
                onPressed: () => _checkAnswer(option, question.correctAnswer),
                child: Text(option,style: TextStyle(color: Colors.black),),
              );
            }),
            const SizedBox(height: 20),
            Text(
              'Unlock rewards as you level up!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.green[700]),
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  Question(this.questionText, this.options, this.correctAnswer);
}
