import 'package:flickrate/app/screens/videos/show_videos_view_model.dart';
import 'package:flickrate/app/screens/videos/widgets/video_tile.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

class ShowVideosView extends StatefulWidget {
  final ShowVideosViewModel model;
  final ColorsPalette colorsPalette = ColorsPalette();
  ShowVideosView({super.key, required this.model});


  @override
  State<ShowVideosView> createState() => _ShowVideosViewState();
}

class _ShowVideosViewState extends State<ShowVideosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.colorsPalette.mainColor,
        foregroundColor: Colors.white,
      ),
      body: widget.model.isURLsLoaded
          ? PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: widget.model.videosURLs.length,
              itemBuilder: (context, index) {
                return VideoTile(
                  url: widget.model.videosURLs[index],
                );
              },
            )
          : Container(
                color: widget.colorsPalette.mainColor,
                height: double.infinity,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
    );
  }
}
