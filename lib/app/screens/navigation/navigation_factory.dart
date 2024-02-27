import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigation_view.dart';
import 'navigation_view_model.dart';

class NavigationFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => NavigationViewModel(),
      child: Consumer<NavigationViewModel>(
        builder: (context, model, child) =>
            NavigationView(navigationViewModel: model),
      ),
    );
  }
}
