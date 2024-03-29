import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key, required this.updateSearchQuery});
  final Function(String value) updateSearchQuery;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  ColorsPalette colorsPalette = ColorsPalette();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: TextFormField(
          onChanged: (value) {
            widget.updateSearchQuery(value);
          },
          maxLength: 20,
          decoration: InputDecoration(
            counterText: '',
            labelStyle: TextStyle(color: colorsPalette.mainColor),
            prefix: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: 'Enter movie name here',
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colorsPalette.mainColor)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorsPalette.mainColor),
            ),
          ),
        ),
      ),
    );
  }
}
