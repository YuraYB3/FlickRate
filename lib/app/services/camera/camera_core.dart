import 'package:camera/camera.dart';

import '../../../domain/camera/icamera_core.dart';

class CameraCore implements ICameraCore {
  
  @override
  late List<CameraDescription> cameraList;

  CameraCore(){
    initialize();
  }

  @override
  Future<void> initialize() async{
    cameraList = await availableCameras();
  }
}
