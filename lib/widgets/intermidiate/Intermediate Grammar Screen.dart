import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class IntermediateGrammarScreen extends StatelessWidget {
  final List<Map<String, String>> grammarExamples = [
    {'Korean': '-에서: 학교에서 공부해요.', 'English': 'I study at school.'},
    {'Korean': '-부터: 수업은 3시부터 시작해요.', 'English': 'The class starts at 3 PM.'},
    {'Korean': '-았/었: 나는 어제 운동했어요.', 'English': 'I exercised yesterday.'},
    {'Korean': '-ㄹ 거예요: 내일 쇼핑할 거예요.', 'English': 'I will go shopping tomorrow.'},
    {'Korean': '-지 않다: 저는 그 영화를 보지 않았어요.', 'English': 'I did not watch that movie.'},
    {'Korean': '-ㄴ/는 것: 한국어 공부하는 것은 재미있어요.', 'English': 'Studying Korean is fun.'},
    {'Korean': '-에 대해: 한국에 대해 알아요.', 'English': 'I know about Korea.'},
    {'Korean': '-게 하다: 선생님이 학생을 웃게 해요.', 'English': 'The teacher makes the students laugh.'},
    {'Korean': '-고 있다: 저는 지금 책을 읽고 있어요.', 'English': 'I am reading a book now.'},
    {'Korean': '-면: 비가 오면 집에 있어요.', 'English': 'If it rains, I stay at home.'},
    {'Korean': '-는 중이다: 저는 점심 먹는 중이에요.', 'English': 'I am in the middle of having lunch.'},
    {'Korean': '-기 때문에: 늦어서 미안해요, 교통이 복잡했기 때문에.', 'English': 'Sorry I’m late; it’s because of the traffic.'},
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSound() async {
    await _audioPlayer.play(AssetSource('sounds/sound.mp3')); // Replace with your sound file path
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
                onPressed: _playSound,
              ),
            );
          },
        ),
      ),
    );
  }
}
