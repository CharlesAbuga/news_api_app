import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app_ui/bloc/get_news/get_news_bloc.dart';
import 'package:news_app_ui/widgets/news_card.dart';
import 'package:news_app_ui/widgets/news_container.dart';
import 'package:news_repository/news_repository.dart';
import 'package:shared_packages/shared_packages.dart';

class TopStories extends StatefulWidget {
  const TopStories({super.key});

  @override
  State<TopStories> createState() => _TopStoriesState();
}

class _TopStoriesState extends State<TopStories> {
  late Future<List<News>> news;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<GetNewsBloc, GetNewsState>(
            builder: (context, state) {
              List index = [];
              if (state is GetNewsSuccess) {
                var carouselItemsWithImages = state.news
                    .where((element) => element.urlToImage != '')
                    .toList();

                // If there are less than 3 items with images, pick randomly from the rest
                if (carouselItemsWithImages.length < 3) {
                  // Get the remaining items that don't have images
                  var remainingItems = state.news
                      .where((element) => element.urlToImage == '')
                      .toList();

                  // Randomly pick the remaining items to fill up the carousel list
                  Random random = Random();
                  while (carouselItemsWithImages.length < 3 &&
                      remainingItems.isNotEmpty) {
                    int randomIndex = random.nextInt(remainingItems.length);
                    carouselItemsWithImages.add(remainingItems[randomIndex]);
                    remainingItems.removeAt(randomIndex); // Avoid duplicates
                  }
                }

                // Ensure there are at least 3 items in the carousel
                if (carouselItemsWithImages.length < 3) {
                  // If there still aren't enough items, repeat the last ones to fill up
                  if (carouselItemsWithImages.isNotEmpty) {
                    carouselItemsWithImages = List.generate(
                      3,
                      (index) => carouselItemsWithImages[
                          index % carouselItemsWithImages.length],
                    );
                  } else {
                    // Handle the case where there are no items to display
                    return const Center(
                        child:
                            Text('No news to display with this search term'));
                  }
                }
// Ensure there are at least 3 items in carouselItems after adding

                return SearchBar1.searchController.text == ''
                    ? CarouselSlider(
                        options: CarouselOptions(
                          height: 200,
                          enlargeFactor: 0.1,
                          viewportFraction: 1,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                        ),
                        items: List.generate(3, (index) {
                          var item = carouselItemsWithImages[index];
                          return NewsCard(
                            title: item.title,
                            description: item.description,
                            imageUrl: item.urlToImage,
                          );
                        }),
                      )
                    : const SizedBox();
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Latest News',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: BlocBuilder<GetNewsBloc, GetNewsState>(
                builder: (context, state) {
              if (state is GetNewsSuccess) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.news.length,
                  itemBuilder: (context, index) {
                    return NewsContainer(
                      url: state.news[index].url,
                      description: state.news[index].description,
                      imageUrl: state.news[index].urlToImage,
                      title: state.news[index].title,
                      author: state.news[index].author,
                      publishedAt: state.news[index].publishedAt,
                    );
                  },
                );
              } else if (state is GetNewsInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetNewsFailure) {
                return Center(
                  child: Text(state.message),
                );
              }
              return SizedBox();
            }),
          )
        ],
      ),
    );
  }
}
