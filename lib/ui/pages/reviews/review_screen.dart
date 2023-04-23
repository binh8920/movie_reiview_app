import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import './widgets/animation_review_widget.dart';
import '../../themes/styles.dart';
import '../../../providers/reviews_provider.dart';

class ReviewScreen extends StatelessWidget {
  static const routeName = '/review';

  final String id;
  const ReviewScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _reviewController = TextEditingController();

    Widget _buildForm() {
      return Container(
        margin: const EdgeInsets.all(24.0),
        child: Column(children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  textAlignVertical: TextAlignVertical.center,
                  showCursor: true,
                  cursorColor: Theme.of(context).iconTheme.color,
                  decoration: InputDecoration(
                    hintText: 'Your name',
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.all(16.0),
                    filled: true,
                    fillColor: Colors.grey[400],
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: customBlue,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name!';
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _reviewController,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  textAlign: TextAlign.justify,
                  showCursor: true,
                  cursorColor: Theme.of(context).iconTheme.color,
                  decoration: InputDecoration(
                    hintText: 'Write your comment here ...',
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.all(16.0),
                    filled: true,
                    fillColor: Colors.grey[400],
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: customBlue,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please leave your review here!';
                    }
                  },
                ),
              ],
            ),
          )
        ]),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(96.0),
        child: AppBar(
          elevation: 0.0,
          titleSpacing: 24.0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          toolbarHeight: 96.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.grey,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.white,
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                  ),
                  iconSize: 20,
                ),
              ),
              Text(
                'Review',
                style: Theme.of(context).appBarTheme.toolbarTextStyle,
              ),
              IconButton(
                splashRadius: 24.0,
                splashColor: Colors.grey[200],
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.send),
                color: Theme.of(context).bottomAppBarColor,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Provider.of<ReviewProvider>(
                      context,
                      listen: false,
                    ).addReview(
                        id, _nameController.text, _reviewController.text);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(child: _buildForm()),
    );
  }
}
