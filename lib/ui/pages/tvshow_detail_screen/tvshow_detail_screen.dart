import 'package:flutter/material.dart';
import '../../../apis/apis.dart';
import '../../../shared_widgets/custom_value.dart';
import '../reviews/review_screen.dart';
import '../../../shared_widgets/review_widget.dart';

class TVDescription extends StatefulWidget {
  final int id;

  TVDescription({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<TVDescription> createState() => _TVDescriptionState();
}

class _TVDescriptionState extends State<TVDescription> {
  int seasonindex = 0;
  Color seasoncolor = Colors.redAccent;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(canvasColor: oppositecolor),
        home: Scaffold(
          body: FutureBuilder(
            future: ApiService().getTVDetail(widget.id.toString()),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                    //scrollDirection: Axis.vertical,
                    child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(25.0)),
                      child: (snapshot.data.backdropPath == null)
                          ? Container(
                              height: 300,
                              width: 1000,
                              color: uppermodecolor,
                            )
                          : Container(
                              height: 300,
                              width: 1000,
                              child: Image.network(
                                'https://image.tmdb.org/t/p/original/${snapshot.data.backdropPath}',
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 30),
                        child: Center(
                          child: Text(
                            snapshot.data.name,
                            style: TextStyle(
                                fontSize: 24,
                                color: uppermodecolor,
                                fontWeight: FontWeight.w300),
                          ),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 26,
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 9),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Colors.blueGrey,
                          ),
                          child: Text(
                            (snapshot.data.firstAirDate == '')
                                ? 'N/A'
                                : snapshot.data.firstAirDate
                                    .toString()
                                    .substring(0, 4),
                            style:
                                TextStyle(fontSize: 14, color: uppermodecolor),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '|',
                          style: TextStyle(fontSize: 30, color: uppermodecolor),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 25,
                            ),
                            Text(
                              snapshot.data.voteAverage
                                  .toString()
                                  .substring(0, 3),
                              style: TextStyle(
                                  fontSize: 16, color: uppermodecolor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '|',
                          style: TextStyle(fontSize: 30, color: uppermodecolor),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '${snapshot.data.episodeRunTime} min',
                          style: TextStyle(fontSize: 16, color: uppermodecolor),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        snapshot.data.overview,
                        style: TextStyle(
                            fontSize: 18,
                            color: uppermodecolor,
                            fontWeight: FontWeight.w200),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.seasons.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  seasonindex = index;
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 100,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: (index == seasonindex)
                                      ? seasoncolor
                                      : Colors.white38,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    '${snapshot.data.seasons[index].name}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: uppermodecolor,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Reviews(movie_id: snapshot.data.id.toString()),
                    Container(
                      width: 500,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReviewScreen(
                                      id: snapshot.data.id.toString(),
                                    )),
                          );
                          print(snapshot.data.id.toString());
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          height: 60,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.redAccent,
                          ),
                          child: Center(
                            child: Text(
                              'LEAVE REVIEW NOW',
                              style: TextStyle(
                                  fontSize: 15, color: uppermodecolor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
              } else {
                return Container();
              }
            },
          ),
        ));
  }
}
