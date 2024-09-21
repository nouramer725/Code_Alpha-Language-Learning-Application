import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Introduction {
  final String sound;
  final String krName; // Korean phrase
  final String enTranslation; // English translation

  const Introduction({
    required this.sound,
    required this.krName,
    required this.enTranslation,
  });
}

class IntroduceYourselfScreen extends StatelessWidget {
  final List<Introduction> introductionList = const [
    Introduction(
      sound: "sounds/introduce/hello.mp3",
      krName: "안녕하세요", // Korean for "Hello"
      enTranslation: "Hello",
    ),
    Introduction(
      sound: "sounds/introduce/my_name_is_nour.mp3",
      krName: "제 이름은 누르입니다", // Korean for "My name is Nour"
      enTranslation: "My name is Nour",
    ),
    Introduction(
      sound: "sounds/introduce/nice_to_meet_you.mp3",
      krName: "만나서 반가워요", // Korean for "Nice to meet you"
      enTranslation: "Nice to meet you",
    ),
    Introduction(
      sound: "sounds/introduce/i_come_from_egypt.mp3",
      krName: "저는 이집트에서 왔어요", // Korean for "I come from Egypt"
      enTranslation: "I come from Egypt",
    ),
    Introduction(
      sound: "sounds/introduce/how_are_you.mp3",
      krName: "잘 지내세요?", // Korean for "How are you?"
      enTranslation: "How are you?",
    ),
    Introduction(
      sound: "sounds/introduce/i_am_fine.mp3",
      krName: "저는 잘 지내요", // Korean for "I am fine"
      enTranslation: "I am fine",
    ),
    Introduction(
      sound: "sounds/introduce/what_is_your_name.mp3",
      krName: "당신의 이름은 무엇입니까?", // Korean for "What is your name?"
      enTranslation: "What is your name?",
    ),
    Introduction(
      sound: "sounds/introduce/my_hobby_is_reading.mp3",
      krName: "저의 취미는 독서입니다", // Korean for "My hobby is reading"
      enTranslation: "My hobby is reading.",
    ),
    Introduction(
      sound: "sounds/introduce/i_like_music.mp3",
      krName: "저는 음악을 좋아합니다", // Korean for "I like music"
      enTranslation: "I like music.",
    ),
    Introduction(
      sound: "sounds/introduce/i_am_studying_korean.mp3",
      krName: "저는 한국어를 공부하고 있어요", // Korean for "I am studying Korean"
      enTranslation: "I am studying Korean.",
    ),
  ];

  final AudioPlayer audioPlayer = AudioPlayer();

  void _playAudio(String fileName) async {
    await audioPlayer.play(AssetSource(fileName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Introduce Yourself'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: introductionList.length,
          itemBuilder: (context, index) {
            final intro = introductionList[index];
            return ListTile(
              title: Text(intro.krName, style: TextStyle(fontSize: 20)),
              subtitle: Text(intro.enTranslation,style: TextStyle(
              ),),
              trailing: IconButton(
                icon: Icon(Icons.volume_up),
                onPressed: () {
                  _playAudio(intro.sound);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
