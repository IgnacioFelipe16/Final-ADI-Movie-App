import 'dart:async';
import 'package:adi_movie_app/HomePage/HomePage.dart';
import 'package:adi_movie_app/apikey/apikey.dart';
import 'package:adi_movie_app/repeatedfunction/userreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:adi_movie_app/repeatedfunction/slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoviesDetails extends StatefulWidget {
  var id;
  MoviesDetails(this.id);

  @override
  State<MoviesDetails> createState() => _MoviesDetailsState();
}

class _MoviesDetailsState extends State<MoviesDetails> {
  List<Map<String, dynamic>> MoviesDetails = [];
  List<Map<String, dynamic>> UserReviews = [];
  List<Map<String, dynamic>> similarmovieslist = [];
  List<Map<String, dynamic>> recommendedmovieslist = [];
  List MoviesGeneres = [];

  Future<void> MoviesDetail() async {
    var moviedetailurl = 'https://api.themoviedb.org/3/movie/' +
        widget.id.toString() +
        '?language=es&api_key=$apikey';

    var UserReviewurl = 'https://api.themoviedb.org/3/movie/' +
        widget.id.toString() +
        '/reviews?language=es-AR&api_key=$apikey';

    var similarmoviesurl = 'https://api.themoviedb.org/3/movie/' +
        widget.id.toString() +
        '/similar?api_key=$apikey';

    var recommendedmoviesurl = 'https://api.themoviedb.org/3/movie/' +
        widget.id.toString() +
        '/recommendations?api_key=$apikey';

    var moviedetailresponse = await http.get(Uri.parse(moviedetailurl));
    if (moviedetailresponse.statusCode == 200) {
      var moviedetailjson = jsonDecode(moviedetailresponse.body);
      print(moviedetailjson['id']);
      for (var i = 0; i < 1; i++) {
        MoviesDetails.add({
          "backdrop_path": moviedetailjson['backdrop_path'],
          "title": moviedetailjson['title'],
          "vote_average": moviedetailjson['vote_average'],
          "overview": moviedetailjson['overview'],
          "release_date": moviedetailjson['release_date'],
          "runtime": moviedetailjson['runtime'],
          "budget": moviedetailjson['budget'],
          "revenue": moviedetailjson['revenue'],
        });
      }

      for (var i = 0; i < moviedetailjson['genres'].length; i++) {
        MoviesGeneres.add(moviedetailjson['genres'][i]['name']);
      }
    } else {}

    var UserReviewresponse = await http.get(Uri.parse(UserReviewurl));
    if (UserReviewresponse.statusCode == 200) {
      var UserReviewjson = jsonDecode(UserReviewresponse.body);
      for (var i = 0; i < UserReviewjson['results'].length; i++) {
        UserReviews.add({
          "name": UserReviewjson['results'][i]['author'],
          "review": UserReviewjson['results'][i]['content'],
          "rating":
              UserReviewjson['results'][i]['author_details']['rating'] == null
                  ? "No calificada"
                  : UserReviewjson['results'][i]['author_details']['rating']
                      .toString(),
          "avatarphoto": UserReviewjson['results'][i]['author_details']
                      ['avatar_path'] ==
                  null
              ? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"
              : "https://image.tmdb.org/t/p/w500" +
                  UserReviewjson['results'][i]['author_details']['avatar_path'],
          "creationdate":
              UserReviewjson['results'][i]['created_at'].substring(0, 10),
          "fullreviewurl": UserReviewjson['results'][i]['url'],
        });
      }
    } else {}

    var similarmoviesresponse = await http.get(Uri.parse(similarmoviesurl));
    if (similarmoviesresponse.statusCode == 200) {
      var similarmoviesjson = jsonDecode(similarmoviesresponse.body);
      for (var i = 0; i < similarmoviesjson['results'].length; i++) {
        similarmovieslist.add({
          "poster_path": similarmoviesjson['results'][i]['poster_path'],
          "name": similarmoviesjson['results'][i]['title'],
          "vote_average": similarmoviesjson['results'][i]['vote_average'],
          "Date": similarmoviesjson['results'][i]['release_date'],
          "id": similarmoviesjson['results'][i]['id'],
        });
      }
    } else {}

    var recommendedmoviesresponse =
        await http.get(Uri.parse(recommendedmoviesurl));
    if (recommendedmoviesresponse.statusCode == 200) {
      var recommendedmoviesjson = jsonDecode(recommendedmoviesresponse.body);
      for (var i = 0; i < recommendedmoviesjson['results'].length; i++) {
        recommendedmovieslist.add({
          "poster_path": recommendedmoviesjson['results'][i]['poster_path'],
          "name": recommendedmoviesjson['results'][i]['title'],
          "vote_average": recommendedmoviesjson['results'][i]['vote_average'],
          "Date": recommendedmoviesjson['results'][i]['release_date'],
          "id": recommendedmoviesjson['results'][i]['id'],
        });
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(14, 14, 14, 1),
        body: FutureBuilder(
          future: MoviesDetail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(FontAwesomeIcons.circleArrowLeft),
                      iconSize: 28,
                      color: Colors.white,
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (route) => false,
                          );
                        },
                        icon: Icon(FontAwesomeIcons.houseUser),
                        iconSize: 25,
                        color: Colors.white,
                      ),
                    ],
                    expandedHeight: MediaQuery.of(context).size.height * 0.4,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: MoviesDetails.isNotEmpty &&
                              MoviesDetails[0]['backdrop_path'] != null
                          ? Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.3),
                                    BlendMode.darken,
                                  ),
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${MoviesDetails[0]['backdrop_path']}',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          : Container(
                              color: Colors.black,
                              child: Center(
                                child: Text(
                                  "Imagen no disponible",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Column(
                      children: [

                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 20),
                          child: Text(
                            MoviesDetails[0]['title'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: MoviesGeneres.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        margin: EdgeInsets.only(right: 10),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(25, 25, 25, 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(MoviesGeneres[index]));
                                  },
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(left: 10, top: 10),
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(25, 25, 25, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                    MoviesDetails[0]['runtime'].toString() +
                                        ' min'))
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        'Sinópsis:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text(MoviesDetails[0]['overview'].toString()),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: UserReview(UserReviews),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'Fecha de estreno: ' +
                          MoviesDetails[0]['release_date'].toString()
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'Presupuesto: \$' +
                          MoviesDetails[0]['budget'].toString() +' USD'
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'Ganancias: \$' +
                          MoviesDetails[0]['revenue'].toString() + ' USD'
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'Puntaje: ' +
                          MoviesDetails[0]['vote_average'].toStringAsFixed(1)
                      ),
                    ),
                    sliderlist(similarmovieslist, "Similares", "movie",
                        similarmovieslist.length),
                    sliderlist(recommendedmovieslist, "Recomendaciones",
                        "movie", recommendedmovieslist.length)
                  ]))
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            }
          },
        ));
  }
}
