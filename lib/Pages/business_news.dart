import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_ui/bloc/get_business_news/get_business_news_bloc.dart';
import 'package:news_app_ui/bloc/get_tech_news/get_tech_news_bloc.dart';
import 'package:news_app_ui/widgets/news_container.dart';

class BusinessNewsScreen extends StatelessWidget {
  const BusinessNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetBusinessNewsBloc, GetBusinessNewsState>(
        builder: (context, state) {
          if (state is GetBusinessNewsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetBusinessNewsSuccess) {
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
