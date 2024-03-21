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
      extendBody: true,
      body: widget._navigationViewModel
          .pages[widget._navigationViewModel.selectedIndex],
      bottomNavigationBar: BottomAppBar(
        height: 60,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
                onPressed: () {
                  widget._navigationViewModel.updateSelectedIndex(0);
                },
                icon: Icon(
                  Icons.home,
                  size: widget._navigationViewModel.iconSize,
                  color: widget._navigationViewModel.selectedIndex == 0
                      ? widget.colorsPalette.mainColor
                      : widget.colorsPalette.secondColor,
                )),
            IconButton(
                onPressed: () {
                  widget._navigationViewModel.updateSelectedIndex(1);
                },
                icon: Icon(
                  Icons.person_rounded,
                  size: widget._navigationViewModel.iconSize,
                  color: widget._navigationViewModel.selectedIndex == 1
                      ? widget.colorsPalette.mainColor
                      : widget.colorsPalette.secondColor,
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: widget._navigationViewModel.onFloatingButtonClicked,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            color: widget.colorsPalette.mainColor,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
