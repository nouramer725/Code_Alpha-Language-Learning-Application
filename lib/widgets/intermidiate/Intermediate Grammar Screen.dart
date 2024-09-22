import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class IntermediateGrammarScreen extends StatelessWidget {
  final List<Map<String, String>> grammarExamples = [
    {'Korean': '-에서: 학교에서 공부해요.', 'English': 'I study at school.', 'sound': 'sounds/inter/school.mp3'},
    {'Korean': '-부터: 수업은 3시부터 시작해요.', 'English': 'The class starts at 3 PM.', 'sound': 'sounds/inter/class.mp3'},
    {'Korean': '-았/었: 나는 어제 운동했어요.', 'English': 'I exercised yesterday.', 'sound': 'sounds/inter/exersice.mp3'},
    {'Korean': '-ㄹ 거예요: 내일 쇼핑할 거예요.', 'English': 'I will go shopping tomorrow.', 'sound': 'sounds/inter/shopping.mp3'},
    {'Korean': '-지 않다: 저는 그 영화를 보지 않았어요.', 'English': 'I did not watch that movie.', 'sound': 'sounds/inter/movie.mp3'},
    {'Korean': '-ㄴ/는 것: 한국어 공부하는 것은 재미있어요.', 'English': 'Studying Korean is fun.', 'sound': 'sounds/inter/studying.mp3'},
    {'Korean': '-에 대해: 한국에 대해 알아요.', 'English': 'I know about Korea.', 'sound': 'sounds/inter/korea.mp3'},
    {'Korean': '-게 하다: 선생님이 학생을 웃게 해요.', 'English': 'The teacher makes the students laugh.', 'sound': 'sounds/inter/teacher.mp3'},
    {'Korean': '-고 있다: 저는 지금 책을 읽고 있어요.', 'English': 'I am reading a book now.', 'sound': 'sounds/inter/reading.mp3'},
    {'Korean': '-면: 비가 오면 집에 있어요.', 'English': 'If it rains, I stay at home.', 'sound': 'sounds/inter/rain.mp3'},
    {'Korean': '-는 중이다: 저는 점심 먹는 중이에요.', 'English': 'I am in the middle of having lunch.', 'sound': 'sounds/inter/lunch.mp3'},
    {'Korean': '-기 때문에: 늦어서 미안해요, 교통이 복잡했기 때문에.', 'English': 'Sorry I’m late; it’s because of the traffic.', 'sound': 'sounds/inter/traffic.mp3'},
  ];

  Future<void> _playSound(String soundPath) async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource(soundPath)); // Play the respective sound
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Intermediate Grammar")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: grammarExamples.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                grammarExamples[index]['Korean']!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(grammarExamples[index]['English']!),
              trailing: IconButton(
                icon: Icon(Icons.volume_up),
                onPressed: () {
                  _playSound(grammarExamples[index]['sound']!); // Play the associated sound
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
