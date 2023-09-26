import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late TextEditingController searchTextController;
  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchTextController,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.blue,
        ),
        suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                searchTextController.clear();
                FocusScope.of(context).unfocus();
              });
            },
            child: const Icon(
              Icons.clear,
              color: Colors.red,
            )),
      ),
      onChanged: (value) {},
      onSubmitted: (value) {},
    );
  }
}
