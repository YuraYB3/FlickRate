import 'package:camera/camera.dart';

import 'icamera_core.dart';

class CameraCore implements ICameraCore {
  @override
  late List<CameraDescription> cameraList;

  @override
  Future<void> initialize() async{
    cameraList = await availableCameras();
  }
}
