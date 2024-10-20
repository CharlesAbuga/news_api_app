import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_ui/Pages/bookmarked_news.dart';
import 'package:news_app_ui/Pages/home_content.dart';
import 'package:news_app_ui/Pages/settings.dart';
import 'package:news_app_ui/Pages/top_stories.dart';
import 'package:news_app_ui/bloc/get_business_news/get_business_news_bloc.dart';
import 'package:news_app_ui/bloc/get_health_news/get_health_news_bloc.dart';
import 'package:news_app_ui/bloc/get_news/get_news_bloc.dart';
import 'package:news_app_ui/bloc/get_tech_news/get_tech_news_bloc.dart';
import 'package:news_app_ui/provider/theme_provider.dart';
import 'package:news_app_ui/themes.dart';
import 'package:provider/provider.dart';
import 'package:shared_packages/shared_packages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool showSearch = false;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    BoookMarkedNews(),
    Settings(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              _selectedIndex == 0 ? Size.fromHeight(150) : Size.fromHeight(60),
          child: AppBar(
            title: AnimatedSwitcher(
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: child,
              ),
              duration: const Duration(milliseconds: 500),
              child: Padding(
                key: ValueKey<bool>(showSearch),
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: showSearch
                    ? Row(
                        children: [
                          Expanded(child: SearchBar1()),
                          BlocBuilder<GetNewsBloc, GetNewsState>(
                            builder: (context, state) {
                              return IconButton(
                                  onPressed: () {
                                    context.read<GetNewsBloc>().add(GetNews());
                                    context
                                        .read<GetHealthNewsBloc>()
                                        .add(GetHealthNews());
                                    context
                                        .read<GetTechNewsBloc>()
                                        .add(GetTechNews());
                                    context.read<GetBusinessNewsBloc>().add(
                                        GetBusinessNews()); // Reset the news
                                  },
                                  icon: Icon(Icons.search));
                            },
                          ),
                        ],
                      )
                    : Consumer<ThemeChange>(builder: (context, theme, child) {
                        return Row(
                          children: [
                            theme.getTheme() == lightTheme
                                ? Image.asset('assets/images/n_single_1.png',
                                    height: 40)
                                : Image.asset('assets/images/n_single_2.png',
                                    height: 40),
                            Text('NEWS APP'.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface)),
                            Spacer(),
                          ],
                        );
                      }),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(!showSearch ? Icons.search : Icons.close),
                onPressed: () {
                  setState(() {
                    showSearch = !showSearch;
                    SearchBar1.searchController.clear();
                    context.read<GetNewsBloc>().add(GetNews());
                    context.read<GetHealthNewsBloc>().add(GetHealthNews());
                    context.read<GetTechNewsBloc>().add(GetTechNews());
                    context.read<GetBusinessNewsBloc>().add(GetBusinessNews());
                  });
                },
              ),
            ],
            bottom: _selectedIndex == 0
                ? const PreferredSize(
                    preferredSize: Size.fromHeight(70),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: TabBar(
                        splashFactory: NoSplash.splashFactory,
                        dividerColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 2,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        tabs: [
                          Tab(
                            text: 'Top Stories',
                            icon: Icon(Icons.newspaper),
                          ),
                          Tab(
                            text: 'Business',
                            icon: Icon(Icons.business),
                          ),
                          Tab(
                            text: 'Tech',
                            icon: Icon(Icons.computer),
                          ),
                          Tab(text: 'Health', icon: Icon(Icons.local_hospital)),
                        ],
                      ),
                    ),
                  )
                : null,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.0),
          child: _widgetOptions[_selectedIndex],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            canvasColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: BottomNavigationBar(
            selectedIconTheme: const IconThemeData(size: 28),
            selectedLabelStyle: Theme.of(context).textTheme.labelMedium,
            unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: 'Bookmarks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
