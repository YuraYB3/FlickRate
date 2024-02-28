import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core_navigation_view.dart';
import 'core_navigation_view_model.dart';

class CoreNavigationFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => CoreNavigationViewModel(),
      child: Consumer<CoreNavigationViewModel>(
        builder: (context, model, child) =>
            CoreNavigationView(navigationViewModel: model),
      ),
    );
  }
}
