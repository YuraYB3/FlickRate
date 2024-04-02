import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'default_url_view.dart';
import 'default_url_view_model.dart';

class DefaultUrlScreenFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => DefaultUrlViewModel(),
      child: Consumer<DefaultUrlViewModel>(
        builder: (context, value, child) => const DefaultUrlView(),
      ),
    );
  }
}
