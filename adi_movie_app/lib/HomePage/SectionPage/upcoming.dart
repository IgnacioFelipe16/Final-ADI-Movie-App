import 'dart:convert';
import 'package:adi_movie_app/repeatedfunction/slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:adi_movie_app/apikey/apikey.dart';

class Upcoming extends StatefulWidget {
  const Upcoming({super.key});

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  List<Map<String, dynamic>> upcomingList = [];

  Future<void> getUpcoming() async {
    var upcomingUrl = Uri.parse('https://api.themoviedb.org/3/discover/movie?&primary_release_year=2025&api_key=$apikey');
  var response = await http.get(upcomingUrl);
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    for (var i=0; i<json['results'].length; i++) {
      upcomingList.add({
        "poster_path": json['results'][i]['poster_path'],
        "name": json['results'][i]['title'],
        "vote_average": json['results'][i]['vote_average'],
        "Date": json['results'][i]['release_date'],
        "id": json['results'][i]['id'],
      });
    }
  } 
  else {
    print("error");
  }
}

@override
Widget build(BuildContext context) {
  return FutureBuilder(
    future: getUpcoming(),
    builder: (context, snapshot) {
      if(snapshot.connectionState==ConnectionState.done) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sliderlist(upcomingList, "Próximamente", "movie", 20),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0, top: 15, bottom: 40
              ),
              child: Text("Y mucho más...")
            )
          ]
        );
      } else {
        return Center(
          child: CircularProgressIndicator(color: Colors.amber));
      }
    });
}
}
