import 'package:flutter/material.dart';

class KoreanMatrixScreen extends StatelessWidget {
  // Define Korean characters and their Romanization
  final List<List<String>> koreanMatrix = [
    ['  ', 'ㄱ', 'ㄴ', 'ㄷ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅅ', 'ㅇ', 'ㅈ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ'],
    ['ㅏ','아', '가', '나', '다', '라', '마', '바', '사', '아', '자', '차', '카', '타', '파', '하'],
    ['ㅑ ','야', '갸', '냐', '댜', '랴', '먀', '뱌', '샤', '야', '쟈', '쵸', '캬', '탸', '펴', '햐'],
    ['ㅓ ','어', '거', '너', '더', '러', '머', '버', '서', '어', '제', '체', '켜', '테', '페', '헤'],
    ['ㅕ','여', '겨', '녀', '됴', '렘', '며', '벼', '셔', '여', '쟈', '쵸', '켜', '텨', '펴', '혀'],
    ['ㅗ','오', '고', '노', '도', '로', '모', '보', '소', '오', '조', '초', '코', '토', '포', '호'],
    ['ㅛ','요', '교', '뇨', '됴', '료', '묘', '벼', '셔', '요', '쥬', '츄', '큐', '투', '퓨', '휴'],
    ['ㅜ','우', '구', '누', '두', '루', '무', '부', '수', '우', '주', '추', '쿠', '투', '푸', '후'],
    ['ㅠ ','유', '규', '뉴', '듀', '류', '뮤', '뷔', '슈', '유', '쥬', '츄', '큐', '튜', '퓨', '휴'],
    ['ㅡ','으', '그', '느', '드', '르', '므', '브', '스', '으', '제', '체', '크', '트', '프', '흐'],
    ['ㅣ','이', '기', '니', '디', '리', '미', '비', '시', '이', '지', '치', '키', '티', '피', '히'],
    ['ㅐ','애', '개', '내', '대', '래', '매', '배', '새', '애', '재', '채', '개', '태', '패', '해']
  ];


  final List<List<String>> romanizationMatrix = [
    ['   ', 'g', 'n', 'd', 'r', 'm', 'b', 's', 'o', 'j', 'ch', 'k', 't', 'p', 'h'],
    ['a', 'ga', 'na', 'da', 'ra', 'ma', 'ba', 'sa', 'a', 'ja', 'cha', 'ka', 'ta', 'pa', 'ha'],
    ['ya', 'gya', 'nya', 'dya', 'rya', 'mya', 'bya', 'sya', 'ya', 'jya', 'chya', 'kya', 'tya', 'pya', 'hya'],
    ['eo', 'geo', 'neo', 'deo', 'reo', 'meo', 'beo', 'seo', 'eo', 'jeo', 'cheo', 'keo', 'teo', 'peo', 'hya'],
    ['yeo', 'gyeo', 'nyeo', 'dyeo', 'ryeo', 'myeo', 'byeo', 'syeo', 'yeo', 'jyeo', 'chyeo', 'kyeo', 'tyeo', 'pyeo', 'hya'],
    ['o', 'go', 'no', 'do', 'ro', 'mo', 'bo', 'so', 'o', 'jo', 'cho', 'ko', 'to', 'po', 'ho'],
    ['yo', 'gyo', 'nyo', 'dyo', 'ryo', 'myo', 'byo', 'syo', 'yo', 'jyo', 'chyo', 'kyo', 'tyo', 'pyu', 'hyo'],
    ['u', 'gu', 'nu', 'du', 'ru', 'mu', 'bu', 'su', 'u', 'ju', 'chu', 'ku', 'tu', 'pu', 'hu'],
    ['yu', 'gyu', 'nyu', 'dyu', 'ryu', 'myu', 'byu', 'syu', 'yu', 'jyu', 'chyu', 'kyu', 'tyu', 'pyu', 'hyu'],
    ['eu', 'geu', 'neu', 'deu', 'reu', 'meu', 'beu', 'seu', 'eu', 'jeu', 'cheu', 'keu', 'teu', 'peu', 'heu'],
    ['i', 'gi', 'ni', 'di', 'ri', 'mi', 'bi', 'si', 'i', 'ji', 'chi', 'ki', 'ti', 'pi', 'hi'],
    ['ae', 'gae', 'nae', 'dae', 'rae', 'mae', 'bae', 'sae', 'ae', 'jae', 'chae', 'kae', 'tae', 'pae', 'hae']
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Korean Characters'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,

        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(koreanMatrix.length, (rowIndex) {
                return Row(
                  children: List.generate(
                    romanizationMatrix[rowIndex].length,
                        (colIndex) {
                      bool isFirstRow = rowIndex == 0;
                      bool isFirstColumn = colIndex == 0;

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isFirstRow || isFirstColumn
                                    ? Colors.blue[100] // Change color for first row and column
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                koreanMatrix[rowIndex][colIndex],
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: isFirstRow || isFirstColumn
                                      ? Colors.black // Change text color if needed
                                      : Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              romanizationMatrix[rowIndex][colIndex],
                              style: TextStyle(
                                fontSize: 14,
                                color: isFirstRow || isFirstColumn
                                    ? Colors.blue // Change text color if needed
                                    : Colors.green[300],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
    }
  }



