import 'package:flickrate/app/screens/camera/camera_view_model.dart';
import 'package:flutter/material.dart';

class BottomRowWidget extends StatelessWidget {
  final Function() switchCamera;
  final Function() takePhoto;
  final Function() recordVideo;
  final Function() changeOption;
  final bool isRecordVideoClicked;
  final ActiveOption activeOption;
  final CameraTask cameraTask;

  final double iconSize = 48;
  const BottomRowWidget(
      {super.key,
      required this.switchCamera,
      required this.takePhoto,
      required this.changeOption,
      required this.activeOption,
      required this.recordVideo,
      required this.isRecordVideoClicked,
      required this.cameraTask});

  @override
  Widget build(BuildContext context) {
    switch (cameraTask) {
      case CameraTask.test:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            !isRecordVideoClicked?
            IconButton(
              onPressed: switchCamera,
              icon: Icon(
                Icons.switch_camera_rounded,
                size: iconSize,
                color: Colors.white,
              ),
            ): Container(),
            IconButton(
              onPressed:
                  activeOption == ActiveOption.camera ? takePhoto : recordVideo,
              icon: activeOption == ActiveOption.camera
                  ? Icon(
                      Icons.camera,
                      size: iconSize,
                      color: Colors.white,
                    )
                  : isRecordVideoClicked == false
                      ? Icon(
                          Icons.videocam,
                          size: iconSize,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.stop,
                          size: iconSize,
                          color: Colors.white,
                        ),
            ),
           !isRecordVideoClicked? IconButton(
              onPressed: changeOption,
              icon: activeOption == ActiveOption.camera
                  ? Icon(
                      Icons.videocam,
                      size: iconSize,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.camera_alt,
                      size: iconSize,
                      color: Colors.white,
                    ),
            ):Container(),
          ],
        );
      case CameraTask.updateProfileImage:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: switchCamera,
              icon: Icon(
                Icons.switch_camera_rounded,
                size: iconSize,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: takePhoto,
              icon: Icon(
                Icons.camera,
                size: iconSize,
                color: Colors.white,
              ),
            ),
          ],
        );
      default:
        return Container();
    }
  }
}
