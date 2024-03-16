import 'package:flutter/material.dart';

import '../../theme/color_palette.dart';
import 'core_navigation_view_model.dart';

class CoreNavigationView extends StatefulWidget {
  final CoreNavigationViewModel _navigationViewModel;
  CoreNavigationView(
      {required CoreNavigationViewModel navigationViewModel, super.key})
      : _navigationViewModel = navigationViewModel;

  final ColorsPalette colorsPalette = ColorsPalette();

  @override
  State<CoreNavigationView> createState() => _CoreNavigationViewState();
}

class _CoreNavigationViewState extends State<CoreNavigationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget._navigationViewModel
          .pages[widget._navigationViewModel.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 32,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: ''),
        ],
        currentIndex: widget._navigationViewModel.selectedIndex,
        selectedItemColor: widget.colorsPalette.mainColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          widget._navigationViewModel.updateSelectedIndex(index);
        },
      ),
    );
  }
}
