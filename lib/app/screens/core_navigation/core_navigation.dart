import 'package:flutter/material.dart';

import '../../theme/color_palette.dart';
import 'core_navigation_view_model.dart';

class CoreNavigation extends StatefulWidget {
  final CoreNavigationViewModel _viewModel;
  CoreNavigation({required CoreNavigationViewModel viewModel, super.key})
      : _viewModel = viewModel;

  final ColorsPalette colorsPalette = ColorsPalette();

  @override
  State<CoreNavigation> createState() => _CoreNavigationState();
}

class _CoreNavigationState extends State<CoreNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: widget._viewModel.pages[widget._viewModel.selectedIndex],
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.white,
        height: 60,
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                  onPressed: () {
                    widget._viewModel.updateSelectedIndex(0);
                  },
                  icon: Icon(
                    Icons.home,
                    size: widget._viewModel.iconSize,
                    color: widget._viewModel.selectedIndex == 0
                        ? widget.colorsPalette.mainColor
                        : widget.colorsPalette.secondColor,
                  )),
              IconButton(
                onPressed: () {
                  widget._viewModel.updateSelectedIndex(1);
                },
                icon: Icon(
                  Icons.search,
                  size: widget._viewModel.iconSize,
                  color: widget._viewModel.selectedIndex == 1
                      ? widget.colorsPalette.mainColor
                      : widget.colorsPalette.secondColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  widget._viewModel.updateSelectedIndex(2);
                },
                icon: Icon(
                  Icons.video_collection,
                  size: widget._viewModel.iconSize,
                  color: widget._viewModel.selectedIndex == 2
                      ? widget.colorsPalette.mainColor
                      : widget.colorsPalette.secondColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  widget._viewModel.updateSelectedIndex(3);
                },
                icon: Icon(
                  Icons.person_rounded,
                  size: widget._viewModel.iconSize,
                  color: widget._viewModel.selectedIndex == 3
                      ? widget.colorsPalette.mainColor
                      : widget.colorsPalette.secondColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
