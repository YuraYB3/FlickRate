import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'search_view.dart';
import 'search_view_model.dart';

class SearchFactory {
  static Widget build() {
    return ChangeNotifierProvider(
        create: (context) => SearchViewModel(),
        child: Consumer<SearchViewModel>(
          builder: (context, model, child) => const SearchView(),
        ));
  }
}
