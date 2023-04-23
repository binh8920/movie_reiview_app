import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/reviews_model.dart';

class ReviewProvider with ChangeNotifier {
  List<Review> _items = [];

  List<Review> _userItems = [];

  List<Review> get userItems {
    return [..._userItems];
  }

  List<Review> get items {
    return [..._items];
  }

  Future<void> fetchUserReview(String movie_id) async {
    final url = Uri.parse('${dotenv.get('URL', fallback: '')}reviews.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<dynamic, dynamic>;
      print(extractedData);
      final List<Review> loadedReview = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((valueId, valueData) {
        if (valueData['movie_id'] == movie_id) {
          loadedReview.add(
            Review(
                id: valueId,
                movie_id: valueData['movie_id'],
                user_name: valueData['user_name'],
                user_review: valueData['user_review'],
                update_at: DateTime.parse(valueData['update_at'])),
          );
        }
      });

      _items = loadedReview;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addReview(
      String movie_id, String user_name, String user_review) async {
    final url = Uri.parse('${dotenv.get('URL', fallback: '')}reviews.json');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'movie_id': movie_id,
          'user_name': user_name,
          'user_review': user_review,
          'update_at': DateTime.now().toString()
        }),
      );
      final newProduct = Review(
          id: json.decode(response.body)['name'],
          movie_id: movie_id,
          user_name: user_name,
          user_review: user_review,
          update_at: DateTime.now());
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
