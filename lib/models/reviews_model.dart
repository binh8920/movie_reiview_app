import 'package:flutter/material.dart';

class Review with ChangeNotifier {
  final String id;
  final String movie_id;
  final String user_name;
  final String user_review;
  final DateTime update_at;

  Review(
      {required this.id,
      required this.movie_id,
      required this.user_name,
      required this.user_review,
      required this.update_at});
}
