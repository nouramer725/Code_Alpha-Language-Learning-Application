import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Movie {
  final String title;
  final String url;

  Movie({required this.title, required this.url});
}

class Series {
  final String title;
  final String url;

  Series({required this.title, required this.url});
}

class Novel {
  final String title;
  final String url;

  Novel({required this.title, required this.url});
}

class ShieldScreen extends StatelessWidget {
  final List<Movie> movieList = [
    Movie(title: "Parasite", url: "https://www.imdb.com/title/tt6751668/"),
    Movie(title: "The Call", url: "https://www.netflix.com/eg-en/title/81342505"),
    Movie(title: "Train to Busan", url: "https://www.imdb.com/title/tt5700672/"),
    Movie(title: "Alive", url: "https://www.netflix.com/eg-en/title/81240831"),
    Movie(title: "Brave Citizen", url: "https://www.imdb.com/title/tt22505214/"),
    Movie(title: "Exit", url: "https://www.imdb.com/title/tt10648440/"),
    Movie(title: "Midnight", url: "https://www.imdb.com/title/tt14757872/"),
    Movie(title: "Midnight Runner", url: "https://www.imdb.com/title/tt7056732/"),
    Movie(title: "My Annoying Brother", url: "https://www.imdb.com/title/tt6388082/"),
    Movie(title: "Seobok", url: "https://www.imdb.com/title/tt13316722/"),
  ];

  final List<Series> seriesList = [
    Series(title: "Crash Landing On You", url: "https://www.netflix.com/eg-en/title/81159258"),
    Series(title: "Mouse", url: "https://www.imdb.com/title/tt13634792/"),
    Series(title: "True Beauty", url: "https://www.netflix.com/eg-en/title/81410834"),
    Series(title: "All Of Us Are Dead", url: "https://www.netflix.com/eg-en/title/81237994"),
    Series(title: "Bad And Crazy", url: "https://www.imdb.com/title/tt15146202/"),
    Series(title: "Flower Of Evil", url: "https://www.netflix.com/eg-en/title/81357268"),
    Series(title: "The Devil Judge", url: "https://www.netflix.com/eg-en/title/81517098"),
    Series(title: "The Good Bad Mother", url: "https://www.netflix.com/eg-en/title/81669775"),
    Series(title: "Twinkling Watermelon", url: "https://www.imdb.com/title/tt27446493/"),
    Series(title: "Vincenzo", url: "https://www.netflix.com/eg-en/title/81365087"),
    Series(title: "Connection", url: "https://www.imdb.com/title/tt30422566/"),
  ];

  final List<Novel> novelList = [
    Novel(title: "Cursed bunny", url: "https://www.google.com.eg/books/edition/Cursed_Bunny/x_ruEAAAQBAJ?hl=en&gbpv=0"),
    Novel(title: "Please Look After Mom", url: "https://www.google.com.eg/books/edition/Please_Look_After_Mom/cG-gPxwzDGwC?hl=en&gbpv=0"),
    Novel(title: "Kim Ji-Young, Born 1982", url: "https://www.google.com.eg/books/edition/Kim_Jiyoung_Born_1982_A_Novel/3iqfDwAAQBAJ?hl=en&gbpv=0"),
    Novel(title: "The Vegetarian", url: "https://www.google.com.eg/books/edition/The_Vegetarian/qtDvCAAAQBAJ?hl=en&gbpv=0"),
    Novel(title: "The Court Dancer", url: "https://www.google.com.eg/books/edition/The_Court_Dancer/8u8_DwAAQBAJ?hl=en&gbpv=0"),
    Novel(title: "Our Twisted Hero", url: "https://www.google.com.eg/books/edition/Our_Twisted_Hero/jCOCAAAAIAAJ?hl=en&gbpv=0&bsq=Our%20Twisted%20Hero"),
    Novel(title: "Human Acts", url: "https://www.google.com.eg/books/edition/_/peBEjgEACAAJ?hl=en&sa=X&ved=2ahUKEwjlro2H2taIAxWZWUEAHcoCDt4Q7_IDegQIGhAF"),
    Novel(title: "I Have the Right to Destroy Myself", url: "https://www.google.com.eg/books/edition/I_Have_the_Right_to_Destroy_Myself/ThJTLRmlN_QC?hl=en&gbpv=0"),
    Novel(title: "The Hen Who Dreamed She Could Fly", url: "https://www.google.com.eg/books/edition/The_Hen_Who_Dreamed_She_Could_Fly/Ip2JDQAAQBAJ?hl=en"),
    Novel(title: "Love in the Big City", url: "https://www.google.com.eg/books/edition/Love_in_the_Big_City/CABAEAAAQBAJ?hl=en"),
  ];

  final List<String> movieImagePaths = [
    'assets/images/movies/parasite.jpg',
    'assets/images/movies/call.jpg',
    'assets/images/movies/train.jpg',
    'assets/images/movies/alive.jpg',
    'assets/images/movies/brave.jpg',
    'assets/images/movies/exit.jpg',
    'assets/images/movies/midnight.jpg',
    'assets/images/movies/midnight_runners.jpg',
    'assets/images/movies/my_annoying_brother.jpg',
    'assets/images/movies/seobook.jpg',
  ];

  final List<String> seriesImagePaths = [
    'assets/images/series/crash_landing_on_you.jpg',
    'assets/images/series/mouse.jpg',
    'assets/images/series/True.jpg',
    'assets/images/series/all_of_us_are_dead.jpg',
    'assets/images/series/bad_and_crazy.jpg',
    'assets/images/series/flower_of_evil.jpg',
    'assets/images/series/the_devil_judge.jpg',
    'assets/images/series/the_good_bad_mother.jpg',
    'assets/images/series/twin.jpg',
    'assets/images/series/vincenzo.jpg',
    'assets/images/series/connection.jpg',
  ];

  final List<String> novelImagePaths = [
    'assets/images/novels/cursed.jpeg',
    'assets/images/novels/Please.jpeg',
    'assets/images/novels/kimm.jpeg',
    'assets/images/novels/veg.jpeg',
    'assets/images/novels/court.jpeg',
    'assets/images/novels/hero.jpg',
    'assets/images/novels/human.jpeg',
    'assets/images/novels/myself.jpeg',
    'assets/images/novels/hen.jpeg',
    'assets/images/novels/love.jpeg',
  ];

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Show a snackbar or dialog if the URL cannot be launched
      throw 'Could not launch $url';
    }
  }

  Widget _buildSection(String title, List<dynamic> items, List<String> imagePaths) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(items.length, (index) {
              final item = items[index];
              final imagePath = imagePaths[index];

              return GestureDetector(
                onTap: () => _launchURL(item.url),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Image.asset(
                        imagePath,
                        height: 350.0,
                        width: 265.0,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: Colors.red.withOpacity(0.9),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                        ),
                        child: TextButton(
                          iconAlignment: IconAlignment.end,
                          child: Icon(Icons.touch_app, color: Colors.white,size: 40,),
                          onPressed: () => _launchURL(item.url),
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection("Movies", movieList, movieImagePaths),
              _buildSection("Series", seriesList, seriesImagePaths),
              _buildSection("Novels", novelList, novelImagePaths),
            ],
          ),
        ),
      ),
    );
  }
}
