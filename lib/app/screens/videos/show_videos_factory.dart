import 'package:flickrate/domain/video/ivideo_repository.dart';
import 'package:flickrate/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'show_videos_view.dart';
import 'show_videos_view_model.dart';

class ShowVideosFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => ShowVideosViewModel(
        videoRepository: locator<IVideoRepository>()
         ),
      child: Consumer<ShowVideosViewModel>(
        builder: (context, model, child) => ShowVideosView(model: model),
      ),
    );
  }
}