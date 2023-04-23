import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../providers/reviews_provider.dart';

class Reviews extends StatefulWidget {
  final String movie_id;

  Reviews({
    required this.movie_id,
  });

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ReviewProvider>(context)
          .fetchUserReview(widget.movie_id)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final reviews = Provider.of<ReviewProvider>(context).items;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: reviews.length,
            itemBuilder: (context, int index) {
              return Column(
                children: [
                  ReviewElement(index: index),
                ],
              );
            },
          );
  }
}

class ReviewElement extends StatelessWidget {
  ReviewElement({Key? key, required this.index}) : super(key: key);

  int index;

  @override
  Widget build(BuildContext context) {
    final reviews = Provider.of<ReviewProvider>(context).items;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          height: 10,
          thickness: 1,
          color: Colors.grey,
        ),
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: NetworkImage(
              "https://cdn-icons-png.flaticon.com/512/3304/3304517.png",
            ),
          ),
          title: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Text(
                    '${reviews[index].user_name} has commented this movie',
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          subtitle: Text(
            DateFormat('dd/MM/yyyy hh:mm').format(reviews[index].update_at),
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          //trailing: const Icon(Icons.more_vert),
        ),
        Row(
          children: [
            const SizedBox(
              width: 70,
            ),
            Text(
              reviews[index].user_review,
              maxLines: 10,
              style: const TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        )
      ],
    );
  }
}
