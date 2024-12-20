import 'package:adi_movie_app/details/moviesdetails.dart';
import 'package:adi_movie_app/details/tvseriesdetail.dart';
import 'package:flutter/material.dart';

class descriptioncheckui extends StatefulWidget {
  var newid;
  var newtype;
  descriptioncheckui(this.newid, this.newtype);

  @override
  State<descriptioncheckui> createState() => _descriptioncheckuiState();
}

class _descriptioncheckuiState extends State<descriptioncheckui> {
  checktype() {
    if (widget.newtype == 'movie') {
      return MoviesDetails(widget.newid);
    }
    else if(widget.newtype == 'tv') {
      return TvSeriesDetails(widget.newid);
    }
    else{
      return errorui();
    }
  }
  @override
  Widget build(BuildContext context) {
    return checktype();
  }
}

Widget errorui() {
  return Scaffold(
    body: Center(
      child: Text("Error"),
    ),
  );
}