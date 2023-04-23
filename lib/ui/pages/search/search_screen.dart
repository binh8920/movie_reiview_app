import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../apis/apis.dart';
import '../../../shared_widgets/custom_grid_view_widget.dart';
import '../../../shared_widgets/custom_value.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String mediatype = 'movie';
  Color moviebutton = Colors.redAccent;
  Color tvbutton = Colors.white38;
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        const SizedBox(
          height: 50,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          height: 50,
          child: CupertinoSearchTextField(
              style: TextStyle(color: uppermodecolor),
              itemColor: uppermodecolor,
              onSubmitted: (value) {
                if (mediatype == 'movie') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GridViewDataMovie(
                            futre: ApiService()
                                .getMovieBySeach(value.toString(), mediatype))),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GridViewDataTV(
                            futre: ApiService()
                                .getTVBySeach(value.toString(), 'tv'))),
                  );
                }
              }),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  mediatype = 'movie';
                  moviebutton = Colors.redAccent;
                  tvbutton = Colors.white38;
                });
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: moviebutton,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.movie,
                        color: uppermodecolor,
                        size: 50,
                      ),
                      Text(
                        'MOVIE',
                        style: TextStyle(fontSize: 15, color: uppermodecolor),
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  mediatype = 'tv';
                  moviebutton = Colors.white38;
                  tvbutton = Colors.redAccent;
                });
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: tvbutton,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.tv,
                        color: uppermodecolor,
                        size: 50,
                      ),
                      Text(
                        'TV SHOW',
                        style: TextStyle(fontSize: 15, color: uppermodecolor),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 500,
          child: FutureBuilder(
              future: ApiService().getGenreList(mediatype),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  return ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 12.5,
                          ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (mediatype == 'movie') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GridViewDataMovie(
                                        futre: ApiService().getMovieByGenre(
                                            snapshot.data[index].id
                                                .toString()))),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GridViewDataTV(
                                        futre: ApiService().getTVByGenre(
                                            snapshot.data[index].id
                                                .toString()))),
                              );
                            }
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                snapshot.data[index].name,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: uppermodecolor,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return Container();
                }
              }),
        )
      ],
    );
  }
}
