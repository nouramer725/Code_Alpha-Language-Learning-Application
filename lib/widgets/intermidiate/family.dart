import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class FamilyMember {
  final String sound;
  final String image;
  final String krName; // Korean name
  final String enName; // English name

  const FamilyMember({
    required this.sound,
    required this.image,
    required this.krName,
    required this.enName,
  });
}

class FamilyMembersScreen extends StatelessWidget {
  final List<FamilyMember> familyMembersList = const [
    FamilyMember(
        sound: "sounds/family_members/father.mp3",
        image: "assets/images/family_members/family_father.png",
        krName: "아버지", // Korean for Father
        enName: "Father"),
    FamilyMember(
        sound: "sounds/family_members/mother.mp3",
        image: "assets/images/family_members/family_mother.png",
        krName: "어머니", // Korean for Mother
        enName: "Mother"),
    FamilyMember(
        sound: "sounds/family_members/grand1.mp3",
        image: "assets/images/family_members/family_grandfather.png",
        krName: "할아버지", // Korean for Grandfather
        enName: "Grandfather"),
    FamilyMember(
        sound: "sounds/family_members/grand2.mp3",
        image: "assets/images/family_members/family_grandmother.png",
        krName: "할머니", // Korean for Grandmother
        enName: "Grandmother"),
    FamilyMember(
        sound: "sounds/family_members/son.mp3",
        image: "assets/images/family_members/family_son.png",
        krName: "아들", // Korean for Son
        enName: "Son"),
    FamilyMember(
        sound: "sounds/family_members/daughter.mp3",
        image: "assets/images/family_members/family_daughter.png",
        krName: "딸", // Korean for Daughter
        enName: "Daughter"),
    FamilyMember(
        sound: "sounds/family_members/younger1.mp3",
        image: "assets/images/family_members/family_younger_brother.png",
        krName: "남동생", // Korean for Younger Brother
        enName: "Younger Brother"),
    FamilyMember(
        sound: "sounds/family_members/younger2.mp3",
        image: "assets/images/family_members/family_younger_sister.png",
        krName: "여동생", // Korean for Younger Sister
        enName: "Younger Sister"),
    FamilyMember(
        sound: "sounds/family_members/oler1.mp3",
        image: "assets/images/family_members/family_older_brother.png",
        krName: "형", // Korean for Older Brother
        enName: "Older Brother"),
    FamilyMember(
        sound: "sounds/family_members/older2.mp3",
        image: "assets/images/family_members/family_older_sister.png",
        krName: "누나", // Korean for Older Sister
        enName: "Older Sister"),
  ];

  final AudioPlayer audioPlayer = AudioPlayer();

  void _playAudio(String fileName) async {
    await audioPlayer.play(AssetSource(fileName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Family Members'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: familyMembersList.length,
          itemBuilder: (context, index) {
            final member = familyMembersList[index];
            return ListTile(
              leading: Image.asset(member.image),
              title: Text(member.krName), // Display Korean name
              subtitle: Text(member.enName,style: TextStyle(
              ),),
              trailing: IconButton(
                icon: Icon(Icons.volume_up),
                onPressed: () {
                  _playAudio(member.sound);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
