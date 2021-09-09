import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_search_app/controller/sarch_controller.dart';
import 'package:movie_search_app/utils/constants.dart';

class MovieSearch extends StatefulWidget {
  @override
  _MovieSearchState createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  final MovieController movieController = Get.put(MovieController());
  TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Icon actionIcon = Icon(Icons.search);
  searchMovie(String movieName) {
    movieController.getSearchedMovie(movieName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Home',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                cursorColor: Colors.grey,
                autofocus: true,
                focusNode: _focusNode,
                controller: searchController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          searchMovie(searchController.text);
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ))),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onEditingComplete: () => searchMovie(searchController.text),
              ),
            ),
            Expanded(
              child: Obx(() => movieController.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : movieController.searchedMovies.length == 0
                      ? Center(
                          child: Text('No Movie Found'),
                        )
                      : ListView.builder(
                          itemCount: movieController.searchedMovies.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                Card(
                                  elevation: 15,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white10,
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.27,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.2,
                                        ),
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              title: Text(
                                                  "${movieController.searchedMovies[index].title}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6),
                                              subtitle: Wrap(
                                                children: movieController
                                                    .searchedMovies[index]
                                                    .category
                                                    .map((e) =>
                                                        Text('${e.category}  '))
                                                    .toList(),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 20),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                color: Colors.green,
                                              ),
                                              child: Text(
                                                "${movieController.searchedMovies[index].rating} " +
                                                    "IMDB",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  width: MediaQuery.of(context).size.width / 3,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "$posterURL${movieController.searchedMovies[index].posterURL}"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            );
                          },
                        )),
            ),
          ],
        ));
  }
}
