import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../apis/apis.dart';
import '../../../../shared_widgets/custom_grid_view_widget.dart';
import '../../../../shared_widgets/custom_widgets.dart';
import '../../movie_detail_screen/movie_detail_screen.dart';
import '../../tvshow_detail_screen/tvshow_detail_screen.dart';

class HomeScreenBody extends StatefulWidget {
  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        FutureBuilder(
          future: ApiService().getTrendingAll(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return CarouselSlider.builder(
                itemCount: 10,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        InkWell(
                  onTap: () {
                    if (snapshot.data[itemIndex].mediaType == 'movie') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MovieDescription(
                                  id: snapshot.data[itemIndex].id,
                                )),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TVDescription(
                                  id: snapshot.data[itemIndex].id,
                                )),
                      );
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      child: Stack(
                        children: <Widget>[
                          Image.network(
                            'https://image.tmdb.org/t/p/original/${snapshot.data[itemIndex].posterPath}',
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                options: CarouselOptions(
                  aspectRatio: 9 / 9,
                  autoPlay: true,
                  viewportFraction: 1,
                ),
              );
            } else {
              return CarouselSlider.builder(
                itemCount: 10,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Container(
                  width: 270,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
                options: CarouselOptions(
                  aspectRatio: 9 / 9,
                  autoPlay: true,
                  viewportFraction: 0.9,
                ),
              );
            }
          },
        ),
        NameBar(
          namebar: 'Trending Movies',
          navigate: GridViewDataMovie(
            futre: ApiService().getTrendingMovie(),
          ),
        ),
        ListViewDataMovie(
          futre: ApiService().getTrendingMovie(),
        ),
        NameBar(
          namebar: 'Trending Tv shows',
          navigate: GridViewDataTV(
            futre: ApiService().getTrendingTVshow(),
          ),
        ),
        ListViewDataTV(
          futre: ApiService().getTrendingTVshow(),
        ),
      ],
    );
  }
}
