import 'package:flickrate/app/theme/color_palete.dart';
import 'package:flutter/material.dart';

import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel viewModel;
  final ColorsPalete colorsPalete;
  const HomeView(
      {required this.colorsPalete, required this.viewModel, super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.colorsPalete.mainColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              widget.viewModel.onLogOutButtonPressed(context);
            },
          ),
        ],
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
