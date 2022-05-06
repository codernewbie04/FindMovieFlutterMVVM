import 'package:belajar_flutter/model/movie.dart';
import 'package:belajar_flutter/view_model/movie_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieListWidget extends StatefulWidget {
  final List<Movie> _movieList;
  final Function _function;

  const MovieListWidget(this._movieList, this._function);

  @override
  _MovieListWidget createState() => _MovieListWidget();
}

class _MovieListWidget extends State<MovieListWidget> {
  Widget _buildMovieItem(Movie movie) {
    Movie? _selectedMovie = Provider.of<MovieViewModel>(context).movie;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: SizedBox(
              width: 50,
              height: 50,
              child: Image.network(movie.poster_path ?? ''),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    movie.title ?? '',
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    movie.release_date ?? '',
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    movie.overview ?? '',
                    style: const TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: widget._movieList.length,
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            Movie data = widget._movieList[index];
            return InkWell(
              onTap: () {
                if (null != data.title) {
                  widget._function(data);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Detail of movie coming soon :)"),
                  ));
                }
              },
              child: _buildMovieItem(data),
            );
          },
        ),
      ]),
    );
  }
}