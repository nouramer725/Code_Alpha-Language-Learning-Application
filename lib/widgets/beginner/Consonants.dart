import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class KoreanConsonantsScreen extends StatelessWidget {
  final List<Data> consonantsList = const [
    Data(sound: "sounds/cons/g.mp3", consonant: 'ㄱ', name: 'g/k'),
    Data(sound: "sounds/cons/n.mp3", consonant: 'ㄴ', name: 'n'),
    Data(sound: "sounds/cons/d.mp3", consonant: 'ㄷ', name: 'd/t'),
    Data(sound: "sounds/cons/r.mp3", consonant: 'ㄹ', name: 'r/l'),
    Data(sound: "sounds/cons/m.mp3", consonant: 'ㅁ', name: 'm'),
    Data(sound: "sounds/cons/b.mp3", consonant: 'ㅂ', name: 'b/p'),
    Data(sound: "sounds/cons/s.mp3", consonant: 'ㅅ', name: 's'),
    Data(sound: "sounds/cons/ng.mp3", consonant: 'ㅇ', name: 'ng/silent'),
    Data(sound: "sounds/cons/j.mp3", consonant: 'ㅈ', name: 'j/ch'),
    Data(sound: "sounds/cons/ch.mp3", consonant: 'ㅊ', name: 'ch'),
    Data(sound: "sounds/cons/k.mp3", consonant: 'ㅋ', name: 'k'),
    Data(sound: "sounds/cons/t.mp3", consonant: 'ㅌ', name: 't'),
    Data(sound: "sounds/cons/p.mp3", consonant: 'ㅍ', name: 'p'),
    Data(sound: "sounds/cons/h.mp3", consonant: 'ㅎ', name: 'h'),
  ];

  final AudioPlayer audioPlayer = AudioPlayer();

  void _playAudio(String fileName) async {
    await audioPlayer.play(AssetSource(fileName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Korean Consonants'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: consonantsList.length,
          itemBuilder: (context, index) {
            final consonantData = consonantsList[index];
            return ListTile(
              leading: Text(
                consonantData.consonant,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              title: Text('Consonant: ${consonantData.name}' ,style: TextStyle(
              ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.volume_up),
                onPressed: () {
                  _playAudio(consonantData.sound);
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
  final String consonant;
  final String name;

  const Data({
    required this.sound,
    required this.consonant,
    required this.name,
  });
}
