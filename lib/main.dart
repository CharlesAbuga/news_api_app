import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:news_app_ui/Pages/homepage.dart';
import 'package:news_app_ui/bloc/bookmark_news/bookmark_news_bloc.dart';
import 'package:news_app_ui/bloc/get_business_news/get_business_news_bloc.dart';
import 'package:news_app_ui/bloc/get_health_news/get_health_news_bloc.dart';
import 'package:news_app_ui/bloc/get_news/get_news_bloc.dart';
import 'package:news_app_ui/bloc/get_tech_news/get_tech_news_bloc.dart';
import 'package:news_app_ui/provider/theme_provider.dart';
import 'package:news_app_ui/simple_bloc_observer.dart';
import 'package:news_app_ui/themes.dart';
import 'package:news_repository/news_repository.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  ThemeChange themeChange = ThemeChange(lightTheme);
  Bloc.observer = SimpleBlocObserver();
  await themeChange.loadTheme();
  runApp(ChangeNotifierProvider(
    create: (context) => themeChange,
    child: BlocProvider(
      create: (context) => BookmarkNewsBloc(
        newsRepository: ApiNewsRepository(),
      ),
      child: MyApp(
        newsRepository: ApiNewsRepository(),
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.newsRepository});

  final NewsRepository newsRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChange>(builder: (context, theme, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme.getTheme(),
        home: RepositoryProvider<GetNewsBloc>(
          create: (context) => GetNewsBloc(newsRepository: newsRepository),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => GetNewsBloc(newsRepository: newsRepository)
                  ..add(const GetNews()),
              ),
              BlocProvider(
                create: (context) =>
                    GetTechNewsBloc(newsRepository: newsRepository)
                      ..add(const GetTechNews()),
              ),
              BlocProvider(
                create: (context) =>
                    GetBusinessNewsBloc(newsRepository: newsRepository)
                      ..add(const GetBusinessNews()),
              ),
              BlocProvider(
                create: (context) =>
                    GetHealthNewsBloc(newsRepository: newsRepository)
                      ..add(GetHealthNews()),
              ),
            ],
            child: const HomePage(),
          ),
        ),
      );
    });
  }
}
