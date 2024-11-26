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

class TvSeriesDetails extends StatefulWidget {
  var id;
  TvSeriesDetails(this.id);

  @override
  State<TvSeriesDetails> createState() => _TvSeriesDetailsState();
}

class _TvSeriesDetailsState extends State<TvSeriesDetails> {
  var seriesdetailjson;
  List<Map<String, dynamic>> TvSeriesDetails = [];
  List<Map<String, dynamic>> UserReviews = [];
  List<Map<String, dynamic>> similarserieslist = [];
  List<Map<String, dynamic>> recommendedserieslist = [];
  List TvSeriesGeneres = [];

  Future<void> TvSeriesDetail() async {
    var seriedetailurl = 'https://api.themoviedb.org/3/tv/' +
        widget.id.toString() +
        '?language=es-AR&api_key=$apikey';

    var UserReviewurl = 'https://api.themoviedb.org/3/tv/' +
        widget.id.toString() +
        '/reviews?language=es&api_key=$apikey';

    var similarseriesurl = 'https://api.themoviedb.org/3/tv/' +
        widget.id.toString() +
        '/similar?api_key=$apikey';

    var recommendedseriesurl = 'https://api.themoviedb.org/3/tv/' +
        widget.id.toString() +
        '/recommendations?api_key=$apikey';

    var seriesdetailresponse = await http.get(Uri.parse(seriedetailurl));
    if (seriesdetailresponse.statusCode == 200) {
      //var seriesdetailjson = jsonDecode(seriesdetailresponse.body);
      seriesdetailjson = jsonDecode(seriesdetailresponse.body);
      for (var i = 0; i < 1; i++) {
          TvSeriesDetails.add({
          "backdrop_path": seriesdetailjson['backdrop_path'],
          "title": seriesdetailjson['original_name'],
          "vote_average": seriesdetailjson['vote_average'],
          "overview": seriesdetailjson['overview'],
          "status": seriesdetailjson['status'],
          "release_date": seriesdetailjson['first_air_date']
        });
      }

      for (var i = 0; i < seriesdetailjson['genres'].length; i++) {
        TvSeriesGeneres.add(seriesdetailjson['genres'][i]['name']);
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

    var similarseriesresponse = await http.get(Uri.parse(similarseriesurl));
    if (similarseriesresponse.statusCode == 200) {
      var similarseriesjson = jsonDecode(similarseriesresponse.body);
      for (var i = 0; i < similarseriesjson['results'].length; i++) {
        similarserieslist.add({
          "poster_path": similarseriesjson['results'][i]['poster_path'],
          "name": similarseriesjson['results'][i]['original_name'],
          "vote_average": similarseriesjson['results'][i]['vote_average'],
          "Date": similarseriesjson['results'][i]['first_air_date'],
          "id": similarseriesjson['results'][i]['id'],
        });
      }
    } else {}

    var recommendedseriesresponse =
        await http.get(Uri.parse(recommendedseriesurl));
    if (recommendedseriesresponse.statusCode == 200) {
      var recommendedseriesjson = jsonDecode(recommendedseriesresponse.body);
      for (var i = 0; i < recommendedseriesjson['results'].length; i++) {
        recommendedserieslist.add({
          "poster_path": recommendedseriesjson['results'][i]['poster_path'],
          "name": recommendedseriesjson['results'][i]['original_name'],
          "vote_average": recommendedseriesjson['results'][i]['vote_average'],
          "Date": recommendedseriesjson['results'][i]['first_air_date'],
          "id": recommendedseriesjson['results'][i]['id'],
        });
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(14, 14, 14, 1),
        body: FutureBuilder(
          future: TvSeriesDetail(),
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
                          //Mata todas las rutas previas y vuelve a la home
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
                      background: TvSeriesDetails.isNotEmpty &&
                              TvSeriesDetails[0]['backdrop_path'] != null
                          ? Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.3),
                                    BlendMode.darken,
                                  ),
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${TvSeriesDetails[0]['backdrop_path']}',
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
                            TvSeriesDetails[0]['title'].toString(),
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
                                  itemCount: TvSeriesGeneres.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        margin: EdgeInsets.only(right: 10),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(25, 25, 25, 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(TvSeriesGeneres[index]));
                                  },
                                ))
                          ],
                        ),
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
                      child: Text(TvSeriesDetails[0]['overview'].toString()),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: UserReview(UserReviews),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text('Fecha de estreno: ' +
                          TvSeriesDetails[0]['release_date'].toString()),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text('Temporadas: ' +
                          seriesdetailjson['seasons'].length.toString()),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'Puntaje: ' + 
                          TvSeriesDetails[0]['vote_average'].toStringAsFixed(1)
                      ),
                    ),
                    sliderlist(similarserieslist, "Similares", "tv",
                        similarserieslist.length),
                    sliderlist(recommendedserieslist, "Recomendaciones",
                        "tv", recommendedserieslist.length)
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