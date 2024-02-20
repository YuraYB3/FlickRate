import 'package:flutter/material.dart';

import '../../theme/color_palete.dart';
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
  void initState() {
    super.initState();
    widget.viewModel.loadPhoneNumber();
  }

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
      body: Center(
        child: Text(
          'Phone Number: ${widget.viewModel.phoneNumber}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
