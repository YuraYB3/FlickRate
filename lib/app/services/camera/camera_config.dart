import 'package:camera/camera.dart';
import 'package:flickrate/app/services/camera/icamera_config.dart';

class CameraConfig implements ICameraConfig {
  @override
  final ResolutionPreset cameraResolutionPreset;
 
 CameraConfig({
  required this.cameraResolutionPreset
 });
}
