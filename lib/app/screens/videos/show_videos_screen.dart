import 'package:flickrate/app/screens/videos/show_videos_view_model.dart';
import 'package:flickrate/app/screens/videos/widgets/video_tile.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flickrate/domain/video/ivideo.dart';
import 'package:flutter/material.dart';

import '../../common/screens/my_empty_screen.dart';
import '../../common/screens/my_error_widget.dart';
import '../../common/screens/my_loading_widget.dart';

class ShowVideosScreen extends StatefulWidget {
  final ShowVideosViewModel model;
  const ShowVideosScreen({super.key, required this.model});

  @override
  State<ShowVideosScreen> createState() => _ShowVideosScreenState();
}

class _ShowVideosScreenState extends State<ShowVideosScreen> {
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
                  return const Center(child: MyLoadingScreen());
                }
                if (snapshot.data!.isEmpty) {
                  return const Center(child: MyEmptyScreen());
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
              color: mainColor,
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
