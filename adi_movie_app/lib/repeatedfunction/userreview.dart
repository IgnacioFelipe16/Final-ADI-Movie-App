import 'package:flutter/material.dart';

class UserReview extends StatefulWidget {
  var revdeatills;
  UserReview(this.revdeatills);
  @override
  State<UserReview> createState() => _UserReviewState();
}

class _UserReviewState extends State<UserReview> {
  bool showall = false;
  @override
  Widget build(BuildContext context){
    List ReviewDetails = widget.revdeatills;
    if (ReviewDetails.length == 0) {
      return Center();
    } else {
      return Column(
        children: [
          Expanded(
            child: Text(
              'User Reviews',
            ),
          )
        ],
      );
    }
  }
}