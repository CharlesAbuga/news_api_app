import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app_ui/bloc/bookmark_news/bookmark_news_bloc.dart';
import 'package:news_repository/news_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.url,
    required this.author,
    required this.publishedAt,
  });

  final String imageUrl;
  final String title;
  final String description;
  final String url;
  final String author;
  final String publishedAt;

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  @override
  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse(widget.url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Theme.of(context).colorScheme.surface,
        ),
        height: 800,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 250,
                    foregroundDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(0.1),
                            Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(1),
                          ]),
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(widget.imageUrl),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    left: 10,
                    bottom: 10,
                    child: Container(
                      child: Text(widget.title,
                          maxLines: 3,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                    ),
                  ),
                ],
              ),
              Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 16,
                            ),
                      ),
                    ),
                  )),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<BookmarkNewsBloc, BookmarkNewsState>(
                      bloc: context.read<BookmarkNewsBloc>(),
                      builder: (context, state) {
                        bool isBookmarked = false;

                        News? existingNews;

                        if (state is BookmarkNewsLoaded) {
                          existingNews = state.bookmarkedNews.firstWhere(
                            (news) => news.title == widget.title,
                            orElse: () => News(
                              author: '',
                              publishedAt: '',
                              title: '',
                              description: '',
                              url: '',
                              urlToImage: '',
                              isBookmarked: false,
                            ),
                          );
                          isBookmarked = existingNews.title.isNotEmpty;
                        }
                        return Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                        isBookmarked
                                            ? 'Removed from bookmarks'
                                            : 'Added to bookmarks',
                                      ),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                  if (isBookmarked && existingNews != null) {
                                    context
                                        .read<BookmarkNewsBloc>()
                                        .add(RemoveBookmarkNews(existingNews));
                                  } else {
                                    context
                                        .read<BookmarkNewsBloc>()
                                        .add(AddBookmarkNews(News(
                                          author: widget.author,
                                          publishedAt: widget.publishedAt,
                                          title: widget.title,
                                          description: widget.description,
                                          url: widget.url,
                                          urlToImage: widget.imageUrl,
                                          isBookmarked: true,
                                        )));
                                  }
                                });
                              },
                              icon: Icon(
                                isBookmarked
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: Colors.orange,
                              ),
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 5),
                          ],
                        );
                      },
                    ),
                    Row(children: [
                      GestureDetector(
                        onTap: () {
                          _launchUrl();
                        },
                        child: Text(
                          'Read More',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.orange,
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    ]),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
