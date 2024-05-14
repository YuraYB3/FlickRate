import 'package:flickrate/app/common/widgets/my_loading_widget.dart';
import 'package:flickrate/domain/video_player_controllers_service/ivideo_player_controllers__service.dart';
import 'package:flickrate/utils/video_player_util.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoTile extends StatefulWidget {
  final String url;
  final VideoPlayerHandler videoPlayerHandler;
  final IVideoPlayerControllersService controllersService;
  final bool shouldVideoPlay;
  const VideoTile({
    super.key,
    required this.url,
    required this.videoPlayerHandler,
    required this.controllersService,
    required this.shouldVideoPlay,
  });

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.videoPlayerHandler
        .initializeVideoController(
      videoPlayerController:
          widget.controllersService.getController(widget.url),
    )
        .then(
      (_) {
        _checkShouldVideoPlay();
      },
    );
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant VideoTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (oldWidget.shouldVideoPlay != widget.shouldVideoPlay) {
          _checkShouldVideoPlay();
        }
      },
    );
  }

  @override
  void dispose() {
    widget.controllersService
        .clearController(controller: widget.videoPlayerHandler.videoController);
    super.dispose();
  }

  void _checkShouldVideoPlay() {
    if (widget.shouldVideoPlay) {
      widget.videoPlayerHandler.playVideo();
    } else {
      widget.videoPlayerHandler.pauseVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.videoPlayerHandler.videoPlayerState) {
      case VideoPlayerState.loading:
        return const MyLoadingScreen();
      case VideoPlayerState.readyToWork:
        return GestureDetector(
            onTap: () {
              widget.videoPlayerHandler.onPlayButtonClicked();
            },
            child: VideoPlayer(widget.videoPlayerHandler.videoController));
    }
  }
}
