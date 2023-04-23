import 'package:flutter/material.dart';
import './custom_value.dart';
import './custom_widgets.dart';
import '../ui/pages/movie_detail_screen/movie_detail_screen.dart';
import '../ui/pages/tvshow_detail_screen/tvshow_detail_screen.dart';

class GridViewDataMovie extends StatefulWidget {
  const GridViewDataMovie({
    Key? key,
    required this.futre,
  }) : super(key: key);

  final Future futre;

  @override
  State<GridViewDataMovie> createState() => _GridViewDataMovieState();
}

class _GridViewDataMovieState extends State<GridViewDataMovie> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(canvasColor: Colors.black54),
      home: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
              preferredSize: const Size(500, 90),
              child: Container(
                height: 45,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Image.asset('assets/appbar.png'),
              )),
          body: Stack(children: [
            BackgroundImage(imageback: selectedbackimg),
            FutureBuilder(
              future: widget.futre,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length == 0) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              child: Image(
                                  image: AssetImage('assets/notfound.png'))),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Flexible(
                          child: SizedBox(
                            height: 800,
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 150,
                                        childAspectRatio: 0.7),
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  if (snapshot.data[index].posterPath == null) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDescription(
                                                    id: snapshot.data[index].id,
                                                  )),
                                        );
                                        print(snapshot.data[index].id);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          color: uppermodecolor,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        margin: const EdgeInsets.only(
                                            left: 5, right: 10, bottom: 10),
                                        child: Center(
                                            child: Text(
                                          '${snapshot.data[index].title}',
                                          style: const TextStyle(fontSize: 20),
                                        )),
                                      ),
                                    );
                                  } else {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDescription(
                                                    id: snapshot.data[index].id,
                                                  )),
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 5, right: 10, bottom: 10),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5.0)),
                                          child: Image.network(
                                            'https://image.tmdb.org/t/p/w500/${snapshot.data[index].posterPath}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }),
                          ),
                        ),
                      ],
                    );
                  }
                } else {
                  return const SizedBox(
                    height: 200,
                  );
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class GridViewDataTV extends StatefulWidget {
  const GridViewDataTV({
    Key? key,
    required this.futre,
  }) : super(key: key);

  final Future futre;

  @override
  State<GridViewDataTV> createState() => _GridViewDataTVState();
}

class _GridViewDataTVState extends State<GridViewDataTV> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(canvasColor: Colors.black54),
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
              preferredSize: const Size(500, 90),
              child: Container(
                height: 45,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Image.asset('assets/appbar.png'),
              )),
          body: Stack(children: [
            BackgroundImage(imageback: selectedbackimg),
            FutureBuilder(
              future: widget.futre,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length == 0) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              child: Image(
                                  image: AssetImage('assets/notfound.png'))),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Flexible(
                          child: SizedBox(
                            height: 800,
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 150,
                                        childAspectRatio: 0.7),
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  if (snapshot.data[index].posterPath == null) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TVDescription(
                                                    id: snapshot.data[index].id,
                                                  )),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          color: uppermodecolor,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        margin: const EdgeInsets.only(
                                            left: 5, right: 10, bottom: 10),
                                        child: Center(
                                            child: Text(
                                          '${snapshot.data[index].name}',
                                          style: const TextStyle(fontSize: 20),
                                        )),
                                      ),
                                    );
                                  } else {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TVDescription(
                                                    id: snapshot.data[index].id,
                                                  )),
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 5, right: 10, bottom: 10),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5.0)),
                                          child: Image.network(
                                            'https://image.tmdb.org/t/p/w500/${snapshot.data[index].posterPath}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }),
                          ),
                        ),
                      ],
                    );
                  }
                } else {
                  return const SizedBox(
                    height: 200,
                  );
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
