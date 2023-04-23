import 'package:flutter/material.dart';
import '../../../../apis/apis.dart';
import '../../../../shared_widgets/custom_grid_view_widget.dart';
import '../../../../shared_widgets/custom_widgets.dart';

class TvScreenBody extends StatefulWidget {
  const TvScreenBody({Key? key}) : super(key: key);

  @override
  State<TvScreenBody> createState() => _TvScreenBodyState();
}

class _TvScreenBodyState extends State<TvScreenBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        NameBar(
          namebar: 'Popular Tv shows',
          navigate: GridViewDataTV(
            futre: ApiService().getPopularTVshow(),
          ),
        ),
        ListViewDataTV(
          futre: ApiService().getPopularTVshow(),
        ),
        NameBar(
          namebar: 'Top Rated Tv shows',
          navigate: GridViewDataTV(
            futre: ApiService().getTopRatedTVshow(),
          ),
        ),
        ListViewDataTV(
          futre: ApiService().getTopRatedTVshow(),
        ),
        NameBar(
          namebar: 'Upcoming Tv shows',
          navigate: GridViewDataTV(
            futre: ApiService().getUpcomingTVshow(),
          ),
        ),
        ListViewDataTV(
          futre: ApiService().getUpcomingTVshow(),
        ),
        NameBar(
          namebar: 'Now Playing Tv shows',
          navigate: GridViewDataTV(
            futre: ApiService().getNowPlayingTVshow(),
          ),
        ),
        ListViewDataTV(
          futre: ApiService().getNowPlayingTVshow(),
        ),
      ],
    );
  }
}
