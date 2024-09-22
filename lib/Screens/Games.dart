import 'dart:math';
import 'package:flutter/material.dart';

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
    // Consonants
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
      Question("How do you say 'I am from Egypt' in Korean?", ["나는 이집트에서 왔어요", "저는 이집트 사람입니다", "그는 이집트에서 왔어요", "그녀는 이집트에서 왔어요"], "저는 이집트 사람입니다"),
      Question("How do you introduce yourself in a formal setting?", ["안녕하세요, 저는", "저는", "나는", "그는"], "안녕하세요, 저는"),
      Question("How do you express your age?", ["저는 나이가", "나는 나이가", "그는 나이가", "그녀는 나이가"], "저는 나이가"),
      Question("How do you say 'nice to meet you' in Korean?", ["반갑습니다", "고맙습니다", "안녕하세요", "안녕히 가세요"], "반갑습니다"),
      Question("What is 'where are you from' in Korean?", ["어디에서 왔어요?", "어디에서 살아요?", "어디에서 공부해요?", "어디에서 일해요?"], "어디에서 왔어요?"),
      Question("What is 'I live in' in Korean?", ["저는 살고 있어요", "나는 살고 있어요", "그는 살고 있어요", "그녀는 살고 있어요"], "저는 살고 있어요"),
      Question("What is 'my hobby is reading' in Korean?", ["저의 취미는 독서입니다", "나는 독서를 좋아합니다", "그는 독서를 좋아합니다", "그녀는 독서를 좋아합니다"], "저의 취미는 독서입니다"),
    ],
    // Food
    [
      Question("What is 'rice' in Korean?", ["밥", "김치", "불고기", "비빔밥"], "밥"),
      Question("What is 'kimchi' in Korean?", ["김치", "불고기", "비빔밥", "라면"], "김치"),
      Question("What is 'bulgogi' in Korean?", ["불고기", "김치", "비빔밥", "라면"], "불고기"),
      Question("What is 'bibimbap' in Korean?", ["비빔밥", "라면", "불고기", "김치"], "비빔밥"),
      Question("What is 'ramen' in Korean?", ["라면", "김치", "불고기", "비빔밥"], "라면"),
      Question("How do you say 'I want to eat' in Korean?", ["먹고 싶어요", "자고 싶어요", "놀고 싶어요", "읽고 싶어요"], "먹고 싶어요"),
      Question("What is 'water' in Korean?", ["물", "커피", "차", "주스"], "물"),
      Question("What is 'coffee' in Korean?", ["커피", "차", "주스", "물"], "커피"),
      Question("How do you say 'please give me' in Korean?", ["주세요", "고마워요", "미안해요", "잘 가요"], "주세요"),
      Question("What is 'fruit' in Korean?", ["과일", "사과", "포도", "배"], "과일"),
    ],
    // Verbs
    [
      Question("What is 'to eat' in Korean?", ["먹다", "자다", "놀다", "읽다"], "먹다"),
      Question("What is 'to sleep' in Korean?", ["자다", "놀다", "읽다", "먹다"], "자다"),
      Question("What is 'to play' in Korean?", ["놀다", "읽다", "먹다", "자다"], "놀다"),
      Question("What is 'to read' in Korean?", ["읽다", "먹다", "자다", "놀다"], "읽다"),
      Question("What is 'to write' in Korean?", ["쓰다", "읽다", "놀다", "자다"], "쓰다"),
      Question("What is 'to speak' in Korean?", ["말하다", "읽다", "쓰다", "먹다"], "말하다"),
      Question("What is 'to listen' in Korean?", ["듣다", "읽다", "쓰다", "먹다"], "듣다"),
      Question("What is 'to study' in Korean?", ["공부하다", "읽다", "놀다", "자다"], "공부하다"),
      Question("What is 'to drink' in Korean?", ["마시다", "먹다", "자다", "읽다"], "마시다"),
      Question("What is 'to learn' in Korean?", ["배우다", "공부하다", "먹다", "자다"], "배우다"),
    ],
  ];


  Question get question => _categories[_currentCategoryIndex][_correctAnswersInCategory % _categories[_currentCategoryIndex].length];

  void _checkAnswer(String selectedAnswer, String correctAnswer) {
    if (selectedAnswer == correctAnswer) {
      _correctAnswersInCategory++;
      _score++;
      if (_correctAnswersInCategory >= _questionsNeededForLevelUp) {
        _levelUp();
      }
    } else {
      _showTryAgainDialog();
    }
    setState(() {});
  }

  void _levelUp() {
    _level++;
    _correctAnswersInCategory = 0;
    if (_level > 8) {
      _showCongratsDialog();
    } else {
      _pointsToNextLevel = _questionsNeededForLevelUp;
      setState(() {});
    }
  }

  void _showTryAgainDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Incorrect!'),
        content: const Text('Try again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showCongratsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Congratulations!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        content: const Text(
          'You have completed all the levels!',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetGame();
            },
            child: const Text(
              'Restart',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  void _resetGame() {
    setState(() {
      _level = 1;
      _correctAnswersInCategory = 0;
      _score = 0;
      _pointsToNextLevel = _questionsNeededForLevelUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Gamified Learning')),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Score: $_score',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            Text(
              'Level: $_level',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 30),
            Text(
              question.text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Column(
              children: question.options.map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () => _checkAnswer(option, question.correctAnswer),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: Text(option),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: _correctAnswersInCategory / _questionsNeededForLevelUp,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 10),
            Text(
              'Correct Answers: $_correctAnswersInCategory / $_questionsNeededForLevelUp',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String text;
  List<String> options;
  final String correctAnswer;

  Question(this.text, this.options, this.correctAnswer){
    this.options = List.from(options)..shuffle(Random()); // Shuffle the answers
     }
}