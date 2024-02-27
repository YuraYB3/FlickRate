import 'package:flickrate/app/screens/home/home_factory.dart';
import 'package:flickrate/app/screens/navigation/navigation_view_model.dart';
import 'package:flickrate/app/screens/news/news_factory.dart';
import 'package:flickrate/app/screens/profile/profile_factory.dart';
import 'package:flickrate/app/screens/search/search_factory.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

class NavigationView extends StatefulWidget {
  final NavigationViewModel _navigationViewModel;
  NavigationView({required NavigationViewModel navigationViewModel, super.key})
      : _navigationViewModel = navigationViewModel;

  final ColorsPalette colorsPalette = ColorsPalette();

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  final List<Widget> _pages = [
    HomeFactory.build(),
    SearchFactory.build(),
    NewsFactory.build(),
    ProfileFactory.build()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[widget._navigationViewModel.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 32,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded), label: ''),
          ],
          currentIndex: widget._navigationViewModel.selectedIndex,
          selectedItemColor: widget.colorsPalette.mainColor,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            widget._navigationViewModel.updateSelectedIndex(index);
          }),
    );
  }
}
