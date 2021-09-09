//@dart=2.9
import 'package:flutter/material.dart';
import 'package:movie_search_app/view/search_movie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.pink))),
      ),
      home: MovieSearch(),
    );
  }
}
