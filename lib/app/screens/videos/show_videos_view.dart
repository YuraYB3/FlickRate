import 'package:flickrate/app/screens/videos/show_videos_view_model.dart';
import 'package:flickrate/app/screens/videos/widgets/video_tile.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flickrate/domain/video/ivideo.dart';
import 'package:flutter/material.dart';

import '../../common/screens/my_empty_screen.dart';
import '../../common/screens/my_error_widget.dart';
import '../../common/screens/my_loading_widget.dart';

class ShowVideosView extends StatefulWidget {
  final ShowVideosViewModel model;
  final ColorsPalette colorsPalette = ColorsPalette();
  ShowVideosView({super.key, required this.model});

  @override
  State<ShowVideosView> createState() => _ShowVideosViewState();
}

class _ShowVideosViewState extends State<ShowVideosView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.model.isURLsLoaded
          ? StreamBuilder<List<IVideo>>(
              stream: widget.model.videoStreamList,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: MyErrorScreen());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: MyLoadingScreen());
                }
                if (snapshot.data!.isEmpty) {
                  return Center(child: MyEmptyScreen());
                }
                final videosData = snapshot.data!;
                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: videosData.length,
                  itemBuilder: (context, index) {
                    final video = videosData[index];
                    return VideoTile(
                      url: video.url,
                    );
                  },
                );
              },
            )
          : Container(
              color: widget.colorsPalette.mainColor,
              height: double.infinity,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            ),
    );
  }
}