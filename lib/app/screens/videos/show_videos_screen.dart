import 'package:flickrate/app/screens/videos/show_videos_view_model.dart';
import 'package:flickrate/app/screens/videos/widgets/video_tile.dart';
import 'package:flickrate/domain/video/ivideo.dart';
import 'package:flickrate/utils/video_player_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/screens/my_empty_screen.dart';
import '../../common/screens/my_error_widget.dart';
import '../../common/widgets/my_loading_widget.dart';

class ShowVideosScreen extends StatefulWidget {
  final ShowVideosViewModel model;
  const ShowVideosScreen({super.key, required this.model});

  @override
  State<ShowVideosScreen> createState() => _ShowVideosScreenState();
}

class _ShowVideosScreenState extends State<ShowVideosScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.model.getVideosURLs();
  }

  @override
  void dispose() {
    widget.model.controllersService.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<IVideo>>(
        stream: widget.model.videoStreamList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: MyErrorScreen(),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: MyLoadingScreen(),
            );
          }
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: MyEmptyScreen(),
            );
          }
          final videosData = snapshot.data!;
          PageController pageController = PageController();
          return PageView.builder(
            onPageChanged: (value) {
              widget.model.updateCurrentVideoIndex(value);
            },
            controller: pageController,
            scrollDirection: Axis.vertical,
            itemCount: videosData.length,
            itemBuilder: (context, index) {
              final video = videosData[index];
              return ChangeNotifierProvider(
                create: (context) => VideoPlayerHandler(),
                child: Consumer<VideoPlayerHandler>(
                  builder: (context, value, child) {
                    return VideoTile(
                      shouldVideoPlay: index == widget.model.currentVideoIndex,
                      controllersService: widget.model.controllersService,
                      videoPlayerHandler: value,
                      url: video.url,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
