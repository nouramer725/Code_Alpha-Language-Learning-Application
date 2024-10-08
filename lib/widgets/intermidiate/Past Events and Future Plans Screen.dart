import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PastFuturePlansScreen extends StatelessWidget {
  final List<Map<String, String>> pastFuturePhrases = [
    {'Korean': '나는 어제 영화를 봤어요.', 'English': 'I watched a movie yesterday.', 'Sound': 'sounds/past/1.mp3'},
    {'Korean': '다음 주에 여행을 갈 거예요.', 'English': 'I will go on a trip next week.', 'Sound': 'sounds/past/2.mp3'},
    {'Korean': '나는 한국어를 공부했어요.', 'English': 'I studied Korean.', 'Sound': 'sounds/past/3.mp3'},
    {'Korean': '내일 친구를 만날 거예요.', 'English': 'I will meet a friend tomorrow.', 'Sound': 'sounds/past/4.mp3'},
    {'Korean': '어제 비가 왔어요.', 'English': 'It rained yesterday.', 'Sound': 'sounds/past/5.mp3'},
    {'Korean': '나는 주말에 집에서 쉴 거예요.', 'English': 'I will rest at home on the weekend.', 'Sound': 'sounds/past/6.mp3'},
    {'Korean': '그녀는 작년에 한국에 갔어요.', 'English': 'She went to Korea last year.', 'Sound': 'sounds/past/7.mp3'},
    {'Korean': '우리는 다음 달에 시험을 볼 거예요.', 'English': 'We will have an exam next month.', 'Sound': 'sounds/past/8.mp3'},
    {'Korean': '나는 어제 친구와 저녁을 먹었어요.', 'English': 'I had dinner with a friend yesterday.', 'Sound': 'sounds/past/9.mp3'},
    {'Korean': '내일은 날씨가 좋을 거예요.', 'English': 'The weather will be nice tomorrow.', 'Sound': 'sounds/past/10.mp3'},
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSound(String soundPath) async {
    await _audioPlayer.play(AssetSource(soundPath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Past and Future Plans")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: pastFuturePhrases.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                pastFuturePhrases[index]['Korean']!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(pastFuturePhrases[index]['English']!),
              trailing: IconButton(
                icon: Icon(Icons.volume_up),
                onPressed: () => _playSound(pastFuturePhrases[index]['Sound']!),
              ),
            );
          },
        ),
      ),
    );
  }
}
