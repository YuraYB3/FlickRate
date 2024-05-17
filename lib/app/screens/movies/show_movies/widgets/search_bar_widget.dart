import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key, required this.updateSearchQuery});
  final Function(String value) updateSearchQuery;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextFormField(
              onChanged: (value) async {
                widget.updateSearchQuery(value);
              },
              maxLength: 20,
              decoration:  InputDecoration(
                border: InputBorder.none,
                counterText: '',
                labelStyle: const TextStyle(color: mainColor),
                prefix: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: AppLocalizations.of(context)!.enter_movie_name,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
