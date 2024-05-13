import 'package:flutter/material.dart';

import '../../theme/color_palette.dart';
import 'core_navigation_view_model.dart';

class CoreNavigation extends StatefulWidget {
  final CoreNavigationViewModel _viewModel;
  const CoreNavigation({required CoreNavigationViewModel viewModel, super.key})
      : _viewModel = viewModel;

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
              children: List.generate(
                widget._viewModel.pages.length,
                (index) {
                  return IconButton(
                    onPressed: () {
                      widget._viewModel.updateSelectedIndex(index);
                    },
                    icon: Icon(
                      widget._viewModel.icons[index],
                      size: widget._viewModel.iconSize,
                      color: widget._viewModel.selectedIndex == index
                          ? mainColor
                          : secondaryColor,
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }
}
