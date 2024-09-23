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
        sound: "sounds/food/kimchi.mp3",
        image: "assets/images/food/kimchi.jpeg",
        krName: "김치",
        enName: "Kimchi"),
    KoreanFood(
        sound: "sounds/food/bibimbab.mp3",
        image: "assets/images/food/bibimbap.jpeg",
        krName: "비빔밥",
        enName: "Bibimbap"),
    KoreanFood(
        sound: "sounds/food/bulgogi.mp3",
        image: "assets/images/food/bulgogi.jpeg",
        krName: "불고기",
        enName: "Bulgogi"),
    KoreanFood(
        sound: "sounds/food/tteokbokki.mp3",
        image: "assets/images/food/tteokbokki.jpeg",
        krName: "떡볶이",
        enName: "Tteokbokki"),
    KoreanFood(
        sound: "sounds/food/sunduba_jjigae.mp3",
        image: "assets/images/food/sundubu_jjigae.jpeg",
        krName: "순두부찌개",
        enName: "Sundubu Jjigae"),
    KoreanFood(
        sound: "sounds/food/japvhae.mp3",
        image: "assets/images/food/Japchae.jpeg",
        krName: "잡채",
        enName: "Japchae"),
    KoreanFood(
        sound: "sounds/food/galbi.mp3",
        image: "assets/images/food/Galbi.jpeg",
        krName: "갈비",
        enName: "Galbi"),
    KoreanFood(
        sound: "sounds/food/samgyetang.mp3",
        image: "assets/images/food/Samgyetang.jpeg",
        krName: "삼계탕",
        enName: "Samgyetang"),
    KoreanFood(
        sound: "sounds/food/naengmyeon.mp3",
        image: "assets/images/food/Naengmyeon.jpeg",
        krName: "냉면",
        enName: "Naengmyeon"),
    KoreanFood(
        sound: "sounds/food/haemul_pajeon.mp3",
        image: "assets/images/food/Haemul Pajeon.jpeg",
        krName: "해물파전",
        enName: "Haemul Pajeon"),
    KoreanFood(
        sound: "sounds/food/soondae.mp3",
        image: "assets/images/food/Soondae.jpeg",
        krName: "순대",
        enName: "Soondae"),
    KoreanFood(
        sound: "sounds/food/gimbap.mp3",
        image: "assets/images/food/Gimbap.jpeg",
        krName: "김밥",
        enName: "Gimbap"),
    KoreanFood(
        sound: "sounds/food/mandu.mp3",
        image: "assets/images/food/Mandu.jpeg",
        krName: "만두",
        enName: "Mandu"),
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
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: foodList.length,
          itemBuilder: (context, index) {
            final food = foodList[index];
            return ListTile(
              leading: Image.asset(food.image,fit: BoxFit.cover,width: 100,),
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
