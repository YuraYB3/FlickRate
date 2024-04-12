import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flickrate/utils/video_player_util.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoTile extends StatefulWidget {
  final String url;
  final ColorsPalette colorsPalette = ColorsPalette();
  final VideoPlayerUtil videoPlayerUtil = VideoPlayerUtil();
  VideoTile({
    super.key,
    required this.url,
  });

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  @override
  void initState() {
    widget.videoPlayerUtil.initVideoPlayer(widget.url);
    super.initState();
  }

  @override
  void dispose() {
    widget.videoPlayerUtil.disposeVideoPlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.videoPlayerUtil.isInitialized
        ? FutureBuilder(
            future: widget.videoPlayerUtil.futureVideoPlayer,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  color: widget.colorsPalette.mainColor,
                  height: double.infinity,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    widget.videoPlayerUtil.onVideoTaped();
                  },
                  child: Container(
                    color: widget.colorsPalette.mainColor,
                    child: VideoPlayer(
                        widget.videoPlayerUtil.videoPlayerController),
                  ),
                );
              }
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
          );
  }
}
