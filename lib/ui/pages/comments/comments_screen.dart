import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'widget/comments_stack.dart';

class MyComments extends StatefulWidget {
  const MyComments({Key? key, this.comments}) : super(key: key);
  final comments;

  @override
  State<MyComments> createState() => _MyCommentsState();
}

class _MyCommentsState extends State<MyComments> {
  final controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommentsScreen(
        controller: controller,
        comments: widget.comments,
      ),
    );
  }
}
