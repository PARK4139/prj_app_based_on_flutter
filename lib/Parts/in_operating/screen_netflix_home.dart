import 'package:flutter/material.dart';

import '../in_operating/my_data_layer.dart';
import 'screen_netflix_home_sub.dart';
import 'screen_netflix_util.dart';

class ScreenNetflixHome extends StatefulWidget {
  ScreenNetflixHome({Key? key}) : super(key: key);

  @override
  State<ScreenNetflixHome> createState() => _ScreenNetflixHomeState();
}

class _ScreenNetflixHomeState extends State<ScreenNetflixHome> {
  late List<Movie> movies;
  late int _imageSliderCurrentPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initMovies();
    initImageSliderCurrentPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false, //자동구현 뒤로가기 버튼 : false
        // foregroundColor: Colors.red,//자동구현 뒤로가기 버튼 : red
        title: Row(
          children: [
            /*뒤로가기 버튼*/ IconButton(
              tooltip: "GO TO INDEX",
              icon: const Icon(Icons.chevron_left, color: Colors.redAccent),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*넷플릭쓰 로고*/ Container(child: Image.asset('assets/app_netflix_logo.png', fit: BoxFit.contain, width: 30), padding: const EdgeInsets.fromLTRB(0, 7, 0, 7), margin: const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                  /*TV 프로그램 버튼*/ InkWell(
                    onTap: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Icon(Icons.warning_outlined, color: Colors.orangeAccent),
                              content: Text("아직 준비되지 않은 서비스입니다!\n준비해서 다시 만나요!"),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("네! 알겠어요!"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }); // setState(() {
                    },
                    child: Container(padding: const EdgeInsets.fromLTRB(0, 7, 0, 7), margin: const EdgeInsets.fromLTRB(0, 0, 0, 0), child: const Text('TV 프로그램', style: TextStyle(fontSize: 14, color: Colors.white38))),
                  ),
                  /*영화 버튼*/ InkWell(
                    onTap: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Icon(Icons.warning_outlined, color: Colors.orangeAccent),
                              content: Text("아직 준비되지 않은 서비스입니다!\n준비해서 다시 만나요!"),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("네! 알겠어요!"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }); // setState(() {
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: const Text('영화', style: TextStyle(fontSize: 14, color: Colors.white38)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Icon(Icons.warning_outlined, color: Colors.orangeAccent),
                              content: Text("아직 준비되지 않은 서비스입니다!\n준비해서 다시 만나요!"),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("네! 알겠어요!"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }); // setState(() {
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: const Text('내가 찜한 콘텐츠', style: TextStyle(fontSize: 14, color: Colors.white38)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: [
            Center(
              child: SizedBox(
                height: 420 + 48 + 5.6,
                child: CarouselSlider(
                  items: [
                    for (Movie movie in movies)
                      Column(
                        children: [
                          /*메인 포스터 버튼*/ InkWell(
                            // TODO: IconButton, TextButton 이 아닌 경우에는 InkWell Button을 만들어 사용해야 여러 이슈를 피할 수 있다.
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenNetflixHomeSub(movies: movies)));
                            },
                            child: Transform.translate(
                              offset: const Offset(0, 0),
                              child: Transform.scale(
                                scale: 0.8,
                                child: Image.asset(movie.img_url),
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0, -20 - 2 - 2 - 2),
                            child: Text(
                              movie.title,
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                  ],
                  activeIndex: 0,
                  autoplay: true,
                  viewportFraction: 0.8,
                  aspectRatio: 16 / 9,
                  onPageChanged: (index) {
                    setState(
                      () {
                        _imageSliderCurrentPage = index;
                      },
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /*내가 찜한 콘텐츠 버튼*/ const SizedBox(
                  width: 80,
                  child: Column(
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 23),
                      SizedBox(height: 6),
                      Text('내가 찜한 콘텐츠', style: TextStyle(color: Colors.white, fontSize: 10)),
                    ],
                  ),
                ),
                /*재생 버튼*/ Container(
                  padding: const EdgeInsets.all(3),
                  height: 40,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Icon(Icons.warning_outlined, color: Colors.orangeAccent),
                              content: Text("아직 준비되지 않은 서비스입니다!\n준비해서 다시 만나요!"),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("네! 알겠어요!"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }); // setState(() {
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 3),
                        Icon(Icons.play_arrow, color: Colors.black, size: 22),
                        Text('재생', style: TextStyle(color: Colors.black, fontSize: 13)),
                        SizedBox(width: 3),
                        // SizedBox(width: 3),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Icon(Icons.warning_outlined, color: Colors.orangeAccent),
                              content: Text("아직 준비되지 않은 서비스입니다!\n준비해서 다시 만나요!"),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("네! 알겠어요!"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }); // setState(() {
                    },
                    child: Column(
                      children: [
                        Icon(Icons.info, color: Colors.white, size: 23),
                        SizedBox(height: 6),
                        Text('정보', style: TextStyle(color: Colors.white, fontSize: 10)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: IndicatorMaker(movies, _imageSliderCurrentPage),
            ),
            const Text('미리보기', style: TextStyle(color: Colors.grey, fontSize: 15)),
            LateralSlideBuilder(items: CirclesAndTitleListMaker(movies)),
            const Text('TV+코미디+가슴 뭉클', style: TextStyle(color: Colors.grey, fontSize: 15)),
            LateralSlideBuilder(items: PosterListMaker(movies)),
            const Text('지금 뜨는 콘텐츠', style: TextStyle(color: Colors.grey, fontSize: 15)),
            LateralSlideBuilder(items: PosterListMaker(movies)),
            const Text('절찬 스트리밍 중+시즌 3', style: TextStyle(color: Colors.grey, fontSize: 15)),
            LateralSlideBuilder(items: PosterListMaker(movies)),
          ],
        ),
      ),
    );
  }

  void initMovies() {
    movies = movies_dummy;
  }

  void initImageSliderCurrentPage() {
    _imageSliderCurrentPage = 0;
  }

  List<Widget> CirclesAndTitleListMaker(List<Movie> movies) {
    List<Widget> lists = [
      for (Movie movie in movies)
        /*미리보기 원형 영화 포스터*/ Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.translate(
                offset: const Offset(-0, -20),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: Colors.amberAccent,
                    // borderRadius: BorderRadius.circular(100),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(movie.img_url, height: 140 + 20),
                ),
              ),
              /*오프셋된 영화 타이틀*/ Transform.translate(
                offset: const Offset(-0, 30),
                child: Text(movie.title, style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
          ),
        ),
    ];
    return lists;
  }

  List<Widget> PosterListMaker(List<Movie> movies) {
    List<Widget> lists = [
      for (Movie movie in movies)
        /* 영화 포스터*/ Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.translate(
                offset: const Offset(-0, -0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.amberAccent,
                    // borderRadius: BorderRadius.circular(100),
                  ),
                  child: Image.asset(movie.img_url, height: 180),
                ),
              ),
            ],
          ),
        ),
    ];
    return lists;
  }

  List<Widget> TitleSliderMaker(List<Movie> movies) {
    String seperator = '    ';
    List<Widget> lists = [
      for (Movie movie in movies) Text(movie.title + seperator, style: TextStyle(fontSize: 14, color: Colors.white38)),
    ];
    return lists;
  }
}