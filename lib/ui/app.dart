import 'dart:ui';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../ui/pages/more/more_screen.dart';
import '../ui/pages/search/search_screen.dart';
import '../ui/pages/comments/comments_screen.dart';
import '../shared_widgets/custom_value.dart';
import '../shared_widgets/custom_widgets.dart';
import '../ui/pages/home/home_screen.dart';
import '../providers/reviews_provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key, required this.index}) : super(key: key);
  int index;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var Screens = [const HomeScreen(), const SearchScreen(), const MoreScreen()];
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  var _isInit = true;
  var _isLoading = false;
  bool showCmt = false;
  var comments;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FloatingActionButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        final url = Uri.parse(
            '${dotenv.get('API_URL', fallback: '')}api/comments/views');
        http.get(url).then((value) {
          final extractedData =
              json.decode(value.body) as Map<dynamic, dynamic>;
          if (extractedData['reviews'] == null) {
            showCmt = true;
          } else {
            showCmt = false;
          }
          comments = extractedData['reviews'].toString();
          setState(() {
            _isLoading = false;
          });
        });
      } catch (error) {
        const errorMessage = 'Something went wrong. Please try again later.';
        _showErrorDialog(errorMessage);
      }
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: SizedBox(),
          )
        : MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (ctx) => ReviewProvider(),
              ),
            ],
            child: MaterialApp(
              theme: ThemeData(canvasColor: oppositecolor),
              debugShowCheckedModeBanner: false,
              home: showCmt
                  ? (SafeArea(
                      child: Scaffold(
                        extendBody: true,
                        body: Stack(
                          children: [
                            BackgroundImage(imageback: selectedbackimg),
                            Screens[widget.index],
                          ],
                        ),
                        bottomNavigationBar: CurvedNavigationBar(
                          key: _bottomNavigationKey,
                          height: 60.0,
                          index: widget.index,
                          items: <Widget>[
                            Icon(
                              Icons.home,
                              size: 30,
                              color: uppermodecolor,
                            ),
                            Icon(
                              Icons.search,
                              size: 30,
                              color: uppermodecolor,
                            ),
                            Icon(
                              Icons.settings,
                              size: 30,
                              color: uppermodecolor,
                            ),
                          ],
                          color: Colors.white10,
                          buttonBackgroundColor: Colors.white10,
                          backgroundColor: Colors.transparent,
                          animationCurve: Curves.easeInOut,
                          animationDuration: const Duration(milliseconds: 600),
                          onTap: (index) =>
                              setState(() => widget.index = index),
                          letIndexChange: (index) => true,
                        ),
                      ),
                    ))
                  : MyComments(
                      comments: comments,
                    ),
            ),
          );
  }
}
