import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({required this.controller, key, this.comments});

  final comments;
  final Completer<WebViewController> controller;
  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      //future: widget.controller.future,
      builder: (ctx, snapshot) {
        final WebViewController? controller = snapshot.data;
        return snapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                body: Container(
                  margin: EdgeInsets.only(top: 50),
                  child: RefreshIndicator(
                    onRefresh: () => controller!.reload(),
                    child: Stack(
                      children: [
                        WebView(
                          initialUrl: widget.comments,
                          onWebViewCreated: (webViewController) {
                            widget.controller.complete(webViewController);
                          },
                          onPageStarted: (url) {
                            setState(() {
                              loadingPercentage = 0;
                            });
                          },
                          javascriptMode: JavascriptMode.unrestricted,
                          // gestureRecognizers: Set()
                          //   ..add(
                          //     Factory<VerticalDragGestureRecognizer>(
                          //         () => VerticalDragGestureRecognizer()
                          //           ..onDown = (DragDownDetails dragDownDetails) {
                          //             webViewController.getScrollY().then((value) {
                          //               if (value == 0 &&
                          //                   dragDownDetails
                          //                           .globalPosition.direction <
                          //                       1) {
                          //                 webViewController.reload();
                          //               }
                          //             });
                          //           }),
                          //   ),
                          onProgress: (progress) {
                            setState(() {
                              loadingPercentage = progress;
                            });
                          },
                          onPageFinished: (url) {
                            setState(() {
                              loadingPercentage = 100;
                            });
                          },
                        ),
                        if (loadingPercentage < 100)
                          LinearProgressIndicator(
                            value: loadingPercentage / 100.0,
                          ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
