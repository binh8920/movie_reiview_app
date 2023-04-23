import 'package:flutter/material.dart';
import '../../../../apis/apis.dart';
import '../../../../shared_widgets/custom_grid_view_widget.dart';
import '../../../../shared_widgets/custom_widgets.dart';

class MovieScreenBody extends StatefulWidget {
  const MovieScreenBody({Key? key}) : super(key: key);

  @override
  State<MovieScreenBody> createState() => _MovieScreenBodyState();
}

class _MovieScreenBodyState extends State<MovieScreenBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        NameBar(
            namebar: 'Popular Movies',
            navigate: GridViewDataMovie(futre: ApiService().getPopularMovie())),
        ListViewDataMovie(futre: ApiService().getPopularMovie()),
        NameBar(
            namebar: 'Top Rated Movies',
            navigate:
                GridViewDataMovie(futre: ApiService().getTopRatedMovie())),
        ListViewDataMovie(futre: ApiService().getTopRatedMovie()),
        NameBar(
            namebar: 'Upcoming Movies',
            navigate:
                GridViewDataMovie(futre: ApiService().getUpcomingMovie())),
        ListViewDataMovie(futre: ApiService().getUpcomingMovie()),
        NameBar(
            namebar: 'Now Playing Movies',
            navigate:
                GridViewDataMovie(futre: ApiService().getNowPlayingMovie())),
        ListViewDataMovie(futre: ApiService().getNowPlayingMovie()),
      ],
    );
  }
}
