import 'package:adi_movie_app/details/checker.dart';
import 'package:adi_movie_app/details/moviesdetails.dart';
import 'package:adi_movie_app/details/tvseriesdetail.dart';
import 'package:flutter/material.dart';

Widget sliderlist(
    List firstlistname, String categorytitle, String type, int itemcount) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 15, bottom: 40),
          child: Text(categorytitle.toString())),
      SizedBox(
          height: 250,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: itemcount,
              itemBuilder: (context, index) {
                // Parsear la fecha desde la cadena
                DateTime? date;
                if (firstlistname[index]['Date'] != null) {
                  try {
                    date = DateTime.parse(firstlistname[index]['Date']);
                  } catch (e) {
                    date = null; // Manejar errores de formato
                  }
                }

                // Fecha límite para la comparación
                DateTime comparisonDate = DateTime(2025, 1, 1);

                return GestureDetector(
                    onTap: () {
                      if (type == 'movie') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MoviesDetails(firstlistname[index]['id']),
                            ));
                      } else if (type == 'tv') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TvSeriesDetails(firstlistname[index]['id']),
                            ));
                      }
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.3),
                                    BlendMode.darken),
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${firstlistname[index]['poster_path']}'),
                                fit: BoxFit.cover)),
                        margin: const EdgeInsets.only(left: 13),
                        width: 170,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 2, left: 6),
                                  child: Text(
                                      firstlistname[index]['Date'] ?? '')),
                              // Condicional para mostrar el Padding basado en DateTime
                              date != null && date.isBefore(comparisonDate)
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          top: 2, right: 6),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2,
                                                  bottom: 2,
                                                  left: 5,
                                                  right: 5),
                                              child: Row(children: [
                                                const Icon(Icons.star,
                                                    color: Colors.yellow,
                                                    size: 15),
                                                const SizedBox(width: 2),
                                                Text(firstlistname[index]
                                                        ['vote_average']
                                                    .toStringAsFixed(1))
                                              ]))))
                                  : const SizedBox.shrink(), // Widget vacío
                            ])));
              })),
      const SizedBox(height: 20),
    ],
  );
}
