import 'package:camera/camera.dart';

abstract class ICameraCore {
  late List<CameraDescription> cameraList;

  Future<void> initialize();
}
