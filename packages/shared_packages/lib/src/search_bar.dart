import 'package:flutter/material.dart';

class SearchBar1 extends StatefulWidget {
  const SearchBar1({super.key});
  static TextEditingController searchController =
      TextEditingController(text: '');

  @override
  State<SearchBar1> createState() => _SearchBar1State();
}

class _SearchBar1State extends State<SearchBar1> {
  final FocusNode _focusNode = FocusNode();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: SearchBar1.searchController,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: 'Search',
      ),
    );
  }
}
