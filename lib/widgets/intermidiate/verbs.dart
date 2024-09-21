import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Verb {
  final String sound;
  final String krName; // Korean verb
  final String enTranslation; // English translation

  const Verb({
    required this.sound,
    required this.krName,
    required this.enTranslation,
  });
}

class VerbsScreen extends StatelessWidget {
  final List<Verb> verbList = const [
    Verb(
      sound: "sounds/verbs/eat.mp3",
      krName: "먹다", // Korean for "to eat"
      enTranslation: "to eat",
    ),
    Verb(
      sound: "sounds/verbs/drink.mp3",
      krName: "마시다", // Korean for "to drink"
      enTranslation: "to drink",
    ),
    Verb(
      sound: "sounds/verbs/go.mp3",
      krName: "가다", // Korean for "to go"
      enTranslation: "to go",
    ),
    Verb(
      sound: "sounds/verbs/come.mp3",
      krName: "오다", // Korean for "to come"
      enTranslation: "to come",
    ),
    Verb(
      sound: "sounds/verbs/speak.mp3",
      krName: "말하다", // Korean for "to speak"
      enTranslation: "to speak",
    ),
    Verb(
      sound: "sounds/verbs/sleep.mp3",
      krName: "자다", // Korean for "to sleep"
      enTranslation: "to sleep",
    ),
    Verb(
      sound: "sounds/verbs/walk.mp3",
      krName: "걷다", // Korean for "to walk"
      enTranslation: "to walk",
    ),
    Verb(
      sound: "sounds/verbs/run.mp3",
      krName: "달리다", // Korean for "to run"
      enTranslation: "to run",
    ),
    Verb(
      sound: "sounds/verbs/read.mp3",
      krName: "읽다", // Korean for "to read"
      enTranslation: "to read",
    ),
    Verb(
      sound: "sounds/verbs/write.mp3",
      krName: "쓰다", // Korean for "to write"
      enTranslation: "to write",
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
        title: Text('Learn Basic Verbs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: verbList.length,
          itemBuilder: (context, index) {
            final verb = verbList[index];
            return ListTile(
              title: Text(verb.krName, style: TextStyle(fontSize: 24)),
              subtitle: Text(verb.enTranslation,style: TextStyle(
              ),),
              trailing: IconButton(
                icon: Icon(Icons.volume_up),
                onPressed: () {
                  _playAudio(verb.sound);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
