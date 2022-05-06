import 'package:belajar_flutter/model/api/api_response.dart';
import 'package:belajar_flutter/model/movie.dart';
import 'package:belajar_flutter/ui/widget/movie_list_widget.dart';
import 'package:belajar_flutter/view_model/movie_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getMovieWidget(BuildContext context, ApiResponse apiResponse) {
    List<Movie>? movieList = apiResponse.data as List<Movie>?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 8,
              child: MovieListWidget(movieList!, (Movie movieList) {
                Provider.of<MovieViewModel>(context, listen: false)
                    .setSelectedMovie(movieList);
              }),
            ),
          ],
        );
      case Status.ERROR:
        return const Center(
          child: Text('Something went wrong, try again!'),
        );
      case Status.INITIAL:
      default:
        return const Center(
          child: Text('Search the movie by title'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _inputController = TextEditingController();
    ApiResponse apiResponse = Provider.of<MovieViewModel>(context).response;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Movie'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TextField(
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        controller: _inputController,
                        onChanged: (value) {},
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            Provider.of<MovieViewModel>(context, listen: false)
                                .setSelectedMovie(null);
                            Provider.of<MovieViewModel>(context, listen: false)
                                .fetchMovieData(value);
                          }
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText: 'Find some movies...',
                        )),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: getMovieWidget(context, apiResponse)),
        ],
      ),
    );
  }
}
