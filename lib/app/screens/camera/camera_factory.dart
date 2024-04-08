import 'package:flickrate/app/screens/camera/camera_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'camera_view.dart';

class CameraFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => CameraViewModel(
       
      ),
      child: Consumer<CameraViewModel>(
        builder: (context, model, child) =>
            const CameraView(),
      ),
    );
  }
}
