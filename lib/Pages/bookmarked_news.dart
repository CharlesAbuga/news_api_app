import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_ui/bloc/bookmark_news/bookmark_news_bloc.dart';
import 'package:news_app_ui/widgets/news_container.dart';

class BoookMarkedNews extends StatefulWidget {
  const BoookMarkedNews({super.key});

  @override
  State<BoookMarkedNews> createState() => _BoookMarkedNewsState();
}

class _BoookMarkedNewsState extends State<BoookMarkedNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<BookmarkNewsBloc, BookmarkNewsState>(
      bloc: context.read<BookmarkNewsBloc>(),
      builder: (context, state) {
        if (state is BookmarkNewsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BookmarkNewsError) {
          return const Center(child: Text('Failed to fetch news'));
        } else if (state is BookmarkNewsLoaded) {
          if (state.bookmarkedNews.isEmpty) {
            return const Center(child: Text('Bookmarked News Empty'));
          }
          return ListView.builder(
            itemCount: state.bookmarkedNews.length,
            itemBuilder: (context, index) {
              return NewsContainer(
                url: state.bookmarkedNews[index].url,
                description: state.bookmarkedNews[index].description,
                imageUrl: state.bookmarkedNews[index].urlToImage,
                title: state.bookmarkedNews[index].title,
                author: state.bookmarkedNews[index].author,
                publishedAt: state.bookmarkedNews[index].publishedAt,
              );
            },
          );
        }
        return const Center(child: Text('No Bookmarked News'));
      },
    ));
  }
}
