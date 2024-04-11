import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/app/screens/camera/camera_view_model.dart';
import 'package:flickrate/domain/camera/icamera_service.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flickrate/domain/video/ivideo_repository.dart';
import 'package:flickrate/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'camera_view.dart';

class CameraFactory {
  static Widget build(
      {required String documentId,
      required String imageName,
      required CameraTask cameraTask}) {
    return ChangeNotifierProvider(
      create: (context) => CameraViewModel(
          myUserRepository: locator<IMyUserRepository>(),
          cameraService: locator<ICameraService>(),
          navigationUtil: context.read<INavigationUtil>(),
          videoRepository: locator<IVideoRepository>(),
          documentId: documentId,
          imageName: imageName,
          cameraTask: cameraTask),
      child: Consumer<CameraViewModel>(
        builder: (context, model, child) => CameraView(model: model),
      ),
    );
  }
}
