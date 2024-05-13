import 'package:flickrate/app/screens/camera/camera_view_model.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

class BottomRowWidget extends StatefulWidget {
  final Function() switchCamera;
  final Function() takePhoto;
  final Function() recordVideo;
  final Function() changeOption;
  final bool isRecordVideoClicked;
  final ActiveOption activeOption;
  final CameraTask cameraTask;
  final ValueNotifier<double> recordingDuration;

  const BottomRowWidget(
      {super.key,
      required this.switchCamera,
      required this.takePhoto,
      required this.changeOption,
      required this.activeOption,
      required this.recordVideo,
      required this.isRecordVideoClicked,
      required this.cameraTask,
      required this.recordingDuration});

  @override
  State<BottomRowWidget> createState() => _BottomRowWidgetState();
}

class _BottomRowWidgetState extends State<BottomRowWidget> {
  final double iconSize = 36;
  @override
  Widget build(BuildContext context) {
    switch (widget.cameraTask) {
      case CameraTask.test:
        return SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              !widget.isRecordVideoClicked
                  ? IconButton(
                      onPressed: widget.switchCamera,
                      icon: Icon(
                        Icons.switch_camera_rounded,
                        size: iconSize,
                        color: Colors.white,
                      ),
                    )
                  : Container(),
              IconButton(
                onPressed: widget.activeOption == ActiveOption.camera
                    ? widget.takePhoto
                    : widget.recordVideo,
                icon: widget.activeOption == ActiveOption.camera
                    ? Icon(
                        Icons.camera,
                        size: iconSize,
                        color: Colors.white,
                      )
                    : widget.isRecordVideoClicked == false
                        ? Icon(
                            Icons.videocam,
                            size: iconSize,
                            color: Colors.white,
                          )
                        : _recordingIndicator(),
              ),
              !widget.isRecordVideoClicked
                  ? IconButton(
                      onPressed: widget.changeOption,
                      icon: widget.activeOption == ActiveOption.camera
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
                    )
                  : Container(),
            ],
          ),
        );
      case CameraTask.updateProfileImage:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: widget.switchCamera,
              icon: Icon(
                Icons.switch_camera_rounded,
                size: iconSize,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: widget.takePhoto,
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

  Widget _recordingIndicator() {
    return Container(
      height: 30,
      width: 30,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: Center(
        child: ValueListenableBuilder(
          valueListenable: widget.recordingDuration,
          builder: (context, value, child) {
            return CircleAvatar(
              radius: value,
              backgroundColor: mainColor,
            );
          },
        ),
      ),
    );
  }
}
