import 'package:flutter/material.dart';
import 'package:news_app_ui/Pages/business_news.dart';
import 'package:news_app_ui/Pages/health_news.dart';
import 'package:news_app_ui/Pages/tech_news.dart';
import 'package:news_app_ui/Pages/top_stories.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TabBarView(
        children: [
          TopStories(),
          BusinessNewsScreen(),
          TechNewsScreen(),
          HealthNewsScreen()
        ],
      ),
    );
  }
}
