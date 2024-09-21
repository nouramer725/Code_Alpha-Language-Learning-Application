import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class KoreanSentencesScreen extends StatelessWidget {
  final List<Data> sentencesList = const [
    Data(
        sound: "sounds/sentences/11.mp3",
        korean: "안녕하세요",
        english: "Hello"),
    Data(
        sound: "sounds/sentences/88.mp3",
        korean: "감사합니다",
        english: "Thank you"),
    Data(
        sound: "sounds/sentences/77.mp3",
        korean: "죄송합니다",
        english: "Sorry"),
    Data(
        sound: "sounds/sentences/44.mp3",
        korean: "저는 학생입니다",
        english: "I am a student"),
    Data(
        sound: "sounds/sentences/99.mp3",
        korean: "이것은 무엇입니까?",
        english: "What is this?"),
    Data(
        sound: "sounds/sentences/10.mp3",
        korean: "화장실이 어디에 있습니까?",
        english: "Where is the bathroom?"),
    Data(
        sound: "sounds/sentences/33.mp3",
        korean: "얼마에요?",
        english: "How much is it?"),
    Data(
        sound: "sounds/sentences/55.mp3",
        korean: "저는 한국어를 공부하고 있습니다",
        english: "I am studying Korean"),
    Data(
        sound: "sounds/sentences/66.mp3",
        korean: "도와주세요",
        english: "Please help"),
    Data(
        sound: "sounds/sentences/22.mp3",
        korean: "좋은 하루 되세요",
        english: "Have a good day"),
  ];

  final AudioPlayer audioPlayer = AudioPlayer();

  KoreanSentencesScreen({super.key});

  void _playAudio(String fileName) async {
    await audioPlayer.play(AssetSource(fileName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Korean Sentences"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: sentencesList.length,
          itemBuilder: (context, index) {
            final sentenceData = sentencesList[index];
            return ListTile(
              title: Text(sentenceData.korean,),
              subtitle: Text(sentenceData.english,style: TextStyle(
              ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.volume_up),
                onPressed: () {
                  _playAudio(sentenceData.sound);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class Data {
  final String sound;
  final String korean;
  final String english;

  const Data({
    required this.sound,
    required this.korean,
    required this.english,
  });
}
