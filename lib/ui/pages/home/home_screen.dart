import 'package:flutter/material.dart';
import './widgets/home_body_widget.dart';
import './widgets/movie_body_widget.dart';
import './widgets/tvshow_body_widget.dart';
import '../../../shared_widgets/custom_value.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Container(
        //   height: 45,
        //   margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        //   child: Image.asset('assets/appbar.png'),
        // ),
        const SizedBox(
          height: 10,
        ),
        TabBar(
          controller: tabController,
          indicatorColor: Colors.pink,
          tabs: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Home',
                  style: TextStyle(
                      fontSize: 20,
                      color: uppermodecolor,
                      fontWeight: FontWeight.w400),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'Movies',
                style: TextStyle(
                    fontSize: 20,
                    color: uppermodecolor,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'TvShows',
                style: TextStyle(
                    fontSize: 20,
                    color: uppermodecolor,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Flexible(
          child: SizedBox(
            height: 1200,
            child: TabBarView(
              controller: tabController,
              children: [
                HomeScreenBody(),
                const MovieScreenBody(),
                const TvScreenBody()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
