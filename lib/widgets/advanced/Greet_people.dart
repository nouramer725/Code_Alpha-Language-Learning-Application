import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class KoreanGreeting {
  final String sound;
  final String krGreeting; // Korean greeting
  final String enGreeting; // English translation

  const KoreanGreeting({
    required this.sound,
    required this.krGreeting,
    required this.enGreeting,
  });
}

class GreetPeopleScreen extends StatelessWidget {
  final List<KoreanGreeting> greetingList = const [
    KoreanGreeting(
        sound: "sounds/greetings/hello.mp3",
        krGreeting: "안녕하세요",
        enGreeting: "Hello"
    ),
    KoreanGreeting(
        sound: "sounds/greetings/good_morning.mp3",
        krGreeting: "좋은 아침",
        enGreeting: "Good Morning"
    ),
    KoreanGreeting(
        sound: "sounds/greetings/good_night.mp3",
        krGreeting: "안녕히 주무세요",
        enGreeting: "Good Night"
    ),
    KoreanGreeting(
        sound: "sounds/greetings/thank_you.mp3",
        krGreeting: "감사합니다",
        enGreeting: "Thank You"
    ),
    KoreanGreeting(
        sound: "sounds/greetings/youre_welcome.mp3",
        krGreeting: "천만에요",
        enGreeting: "You're Welcome"
    ),
    KoreanGreeting(
        sound: "sounds/greetings/goodbye.mp3",
        krGreeting: "안녕히 가세요",
        enGreeting: "Goodbye"
    ),
    KoreanGreeting(
        sound: "sounds/greetings/see_you.mp3",
        krGreeting: "다음에 봐요",
        enGreeting: "See You"
    ),
    KoreanGreeting(
        sound: "sounds/greetings/im_sorry.mp3",
        krGreeting: "죄송합니다",
        enGreeting: "I'm Sorry"
    ),
    KoreanGreeting(
        sound: "sounds/greetings/excuse_me.mp3",
        krGreeting: "실례합니다",
        enGreeting: "Excuse Me"
    ),
    KoreanGreeting(
        sound: "sounds/greetings/how_it_going.mp3",
        krGreeting: "어떻게 지내세요?",
        enGreeting: "How's It Going?"
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
        title: Text('Korean Greetings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: greetingList.length,
          itemBuilder: (context, index) {
            final greeting = greetingList[index];
            return ListTile(
              leading: Icon(Icons.people_alt_rounded),
              title: Text(
                greeting.krGreeting,
                style: TextStyle(fontSize: 20),
              ), // Display Korean greeting
              subtitle: Text(greeting.enGreeting,style: TextStyle(
              ),),
              trailing: IconButton(
                icon: Icon(Icons.volume_up),
                onPressed: () {
                  _playAudio(greeting.sound);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
