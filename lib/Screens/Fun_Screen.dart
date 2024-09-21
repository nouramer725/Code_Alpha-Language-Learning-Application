import 'package:flutter/material.dart';

class Movie {
  final String title;

  Movie({required this.title});
}

class Series {
  final String title;

  Series({required this.title});
}

class Novel {
  final String title;

  Novel({required this.title});
}

class ShieldScreen extends StatelessWidget {
  final List<Movie> movieList = [
    Movie(title: "Alive"),
    Movie(title: "Brave"),
    Movie(title: "Call"),
    Movie(title: "Exit"),
    Movie(title: "Midnight"),
    Movie(title: "Midnight Runner"),
    Movie(title: "My Annoying Brother"),
    Movie(title: "Parasite"),
    Movie(title: "Seobook"),
    Movie(title: "Train to Busan"),
  ];

  final List<Series> seriesList = [
    Series(title: "All Of Us Are Dead"),
    Series(title: "Bad And Crazy"),
    Series(title: "Crash Landing On You"),
    Series(title: "Flower Of Evil"),
    Series(title: "Mouse"),
    Series(title: "The Devil Judge"),
    Series(title: "The Good Bad Mother"),
    Series(title: "True Beauty"),
    Series(title: "Twinkling Watermelon"),
    Series(title: "Vincenzo"),
    Series(title: "Connection"),
  ];

  final List<Novel> novelList = [
    Novel(title: "Kill the Sun"),
    Novel(title: "Please Look After Mom"),
    Novel(title: "Kim Ji-Young, Born 1982"),
    Novel(title: "The Vegetarian"),
    Novel(title: "The Court Dancer"),
    Novel(title: "Our Twisted Hero"),
    Novel(title: "Human Acts"),
    Novel(title: "I Have the Right to Destroy Myself"),
    Novel(title: "The Hen Who Dreamed She Could Fly"),
    Novel(title: "Love in the Big City"),
  ];

  final List<String> movieImagePaths = [
    'assets/images/movies/alive.jpg',
    'assets/images/movies/brave.jpg',
    'assets/images/movies/call.jpg',
    'assets/images/movies/exit.jpg',
    'assets/images/movies/midnight.jpg',
    'assets/images/movies/midnight_runners.jpg',
    'assets/images/movies/my_annoying_brother.jpg',
    'assets/images/movies/parasite.jpg',
    'assets/images/movies/seobook.jpg',
    'assets/images/movies/train.jpg',
  ];

  final List<String> seriesImagePaths = [
    'assets/images/series/all_of_us_are_dead.jpg',
    'assets/images/series/bad_and_crazy.jpg',
    'assets/images/series/crash_landing_on_you.jpg',
    'assets/images/series/flower_of_evil.jpg',
    'assets/images/series/mouse.jpg',
    'assets/images/series/the_devil_judge.jpg',
    'assets/images/series/the_good_bad_mother.jpg',
    'assets/images/series/True.jpg',
    'assets/images/series/twin.jpg',
    'assets/images/series/vincenzo.jpg',
    'assets/images/series/connection.jpg',
  ];

  final List<String> novelImagePaths = [
    'assets/images/novels/sun.jpeg',
    'assets/images/novels/Please.jpeg',
    'assets/images/novels/kim.jpeg',
    'assets/images/novels/the.jpeg',
    'assets/images/novels/court.jpeg',
    'assets/images/novels/hero.jpg',
    'assets/images/novels/human.jpeg',
    'assets/images/novels/myself.jpeg',
    'assets/images/novels/hen.jpeg',
    'assets/images/novels/love.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movies Section
              Center(
                child: Text(
                  "Movies",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(movieList.length, (index) {
                    final movie = movieList[index];
                    final imagePath = movieImagePaths[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Image.asset(
                            imagePath,
                            height: 250.0,
                            width: 200.0,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.7),
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              movie.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 30),

              // Series Section
              Center(
                child: Text(
                  "Series",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(seriesList.length, (index) {
                    final series = seriesList[index];
                    final imagePath = seriesImagePaths[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Image.asset(
                            imagePath,
                            height: 250.0,
                            width: 200.0,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.7),
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              series.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 30),

              // Novels Section
              Center(
                child: Text(
                  "Novels",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(novelList.length, (index) {
                    final novel = novelList[index];
                    final imagePath = novelImagePaths[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Image.asset(
                            imagePath,
                            height: 250.0,
                            width: 200.0,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.7),
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              novel.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
