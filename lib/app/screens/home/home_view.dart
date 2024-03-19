import 'package:flickrate/app/common/widgets/my_loading_widget.dart';
import 'package:flutter/material.dart';

import 'home_view_model.dart';
import 'widgets/home_screen.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel model;
  const HomeView({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: model.imgURL.isNotEmpty
            ? SizedBox(
                height: screenHeight,
                child: model.homeState == HomeViewState.loadingInfo
                    ? MyLoadingWidget()
                    : HomeScreen(
                        model: model,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth),
              )
            : MyLoadingWidget());
  }
}
