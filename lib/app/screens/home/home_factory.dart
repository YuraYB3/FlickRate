import 'package:flickrate/domain/local_storage/ilocal_storage.dart';
import 'package:flickrate/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routing/inavigation_util.dart';
import 'home_view.dart';
import 'home_view_model.dart';

class HomeFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
        localStorage: locator<ILocalStorage>(),
        navigationUtil: context.read<INavigationUtil>(),
      ),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => HomeView(model: model),
      ),
    );
  }
}
