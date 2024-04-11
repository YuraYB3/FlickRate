
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoTile extends StatefulWidget {
  final String url;
  final ColorsPalette colorsPalette = ColorsPalette();
   VideoTile({
    super.key,
    required this.url,
  });

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  late VideoPlayerController videoPlayerController;
  late Future _initVideoPlayer;

  @override
  void initState() {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _initVideoPlayer = videoPlayerController.initialize();
    videoPlayerController.setLooping(true);
    videoPlayerController.play();
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initVideoPlayer,
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
        }
        else{
          return Container(
            color: widget.colorsPalette.mainColor,
            child: VideoPlayer(videoPlayerController));
        }
      },
    );
  }
}
