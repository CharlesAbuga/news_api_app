import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_ui/bloc/get_health_news/get_health_news_bloc.dart';

import 'package:news_app_ui/widgets/news_container.dart';

class HealthNewsScreen extends StatelessWidget {
  const HealthNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetHealthNewsBloc, GetHealthNewsState>(
        builder: (context, state) {
          if (state is GetHealthNewsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetHealthNewsSuccess) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: state.news.length,
                itemBuilder: (context, index) {
                  print(state.news[index].url);
                  return NewsContainer(
                    url: state.news[index].url,
                    description: state.news[index].description,
                    imageUrl: state.news[index].urlToImage,
                    title: state.news[index].title,
                    author: state.news[index].author,
                    publishedAt: state.news[index].publishedAt,
                  );
                });
          }
          return const Center(
            child: Text('Failed to fetch news'),
          );
        },
      ),
    );
  }
}
