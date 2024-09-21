import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class KoreanFood {
  final String sound;
  final String image;
  final String krName; // Korean name
  final String enName; // English name

  const KoreanFood({
    required this.sound,
    required this.image,
    required this.krName,
    required this.enName,
  });
}

class KoreanFoodScreen extends StatelessWidget {
  final List<KoreanFood> foodList = const [
    KoreanFood(
        sound: "sounds/food/kimchi.mp3", // Changed to .mp3
        image: "assets/images/food/kimchi.jpeg",
        krName: "김치", // Korean for Kimchi
        enName: "Kimchi"),
    KoreanFood(
        sound: "sounds/food/bibimbab.mp3", // Changed to .mp3
        image: "assets/images/food/bibimbap.jpeg",
        krName: "비빔밥", // Korean for Bibimbap
        enName: "Bibimbap"),
    KoreanFood(
        sound: "sounds/food/bulgogi.mp3", // Changed to .mp3
        image: "assets/images/food/bulgogi.jpeg",
        krName: "불고기", // Korean for Bulgogi
        enName: "Bulgogi"),
    KoreanFood(
        sound: "sounds/food/tteokbokki.mp3", // Changed to .mp3
        image: "assets/images/food/tteokbokki.jpeg",
        krName: "떡볶이", // Korean for Tteokbokki
        enName: "Tteokbokki"),
    KoreanFood(
        sound: "sounds/food/sunduba_jjigae.mp3", // Changed to .mp3
        image: "assets/images/food/sundubu_jjigae.jpeg",
        krName: "순두부찌개", // Korean for Sundubu Jjigae
        enName: "Sundubu Jjigae"),
  ];

  final AudioPlayer audioPlayer = AudioPlayer();

  void _playAudio(String fileName) async {
    await audioPlayer.play(AssetSource(fileName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Korean Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: foodList.length,
          itemBuilder: (context, index) {
            final food = foodList[index];
            return ListTile(
              leading: Image.asset(food.image , fit: BoxFit.cover,width: 80,),
              title: Text(food.krName, style: TextStyle(
                fontSize: 31
              ),), // Display Korean name
              subtitle: Text(food.enName,style: TextStyle(
              ),),
              trailing: IconButton(
                icon: Icon(Icons.volume_up),
                onPressed: () {
                  _playAudio(food.sound);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
