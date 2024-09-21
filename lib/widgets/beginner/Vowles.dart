import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class KoreanVowelsScreen extends StatelessWidget {
  final List<Data> koreanVowelsList = const [
    Data(sound: "sounds/vowels/1.mp3", vowel: 'ㅏ', name: 'a'),
    Data(sound: "sounds/vowels/2.mp3", vowel: 'ㅑ', name: 'ya'),
    Data(sound: "sounds/vowels/3.mp3", vowel: 'ㅓ', name: 'eo'),
    Data(sound: "sounds/vowels/4.mp3", vowel: 'ㅕ', name: 'yeo'),
    Data(sound: "sounds/vowels/5.mp3", vowel: 'ㅗ', name: 'o'),
    Data(sound: "sounds/vowels/6.mp3", vowel: 'ㅛ', name: 'yo'),
    Data(sound: "sounds/vowels/7.mp3", vowel: 'ㅜ', name: 'u'),
    Data(sound: "sounds/vowels/8.mp3", vowel: 'ㅠ', name: 'yu'),
    Data(sound: "sounds/vowels/9.mp3", vowel: 'ㅡ', name: 'eu'),
    Data(sound: "sounds/vowels/10.mp3", vowel: 'ㅣ', name: 'i'),
    Data(sound: "sounds/vowels/11.mp3", vowel: 'ㅐ', name: 'ae'),
    Data(sound: "sounds/vowels/12.mp3", vowel: 'ㅒ', name: 'yae'),
    Data(sound: "sounds/vowels/13.mp3", vowel: 'ㅔ', name: 'e'),
    Data(sound: "sounds/vowels/14.mp3", vowel: 'ㅖ', name: 'ye'),
  ];

  final AudioPlayer audioPlayer = AudioPlayer();

  void _playAudio(String fileName) async {
    await audioPlayer.play(AssetSource(fileName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Korean Vowels'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: koreanVowelsList.length,
          itemBuilder: (context, index) {
            final vowelData = koreanVowelsList[index];
            return ListTile(
              leading: Text(
                vowelData.vowel,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              title: Text('Vowel: ${vowelData.name}',style: TextStyle(
              ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.volume_up),
                onPressed: () {
                  _playAudio(vowelData.sound);
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
  final String vowel;
  final String name;

  const Data({
    required this.sound,
    required this.vowel,
    required this.name,
  });
}
