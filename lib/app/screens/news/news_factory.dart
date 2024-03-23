import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'news_view.dart';
import 'news_view_model.dart';

class NewsFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => NewsViewModel(),
      child: Consumer<NewsViewModel>(
        builder: (context, model, child) => const NewsView(),
      ),
    );
  }
}
