// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:io';

import 'package:flickrate/app/screens/camera/camera_view_model.dart';
import 'package:flickrate/app/screens/camera/widgets/preview_widget.dart';
import 'package:flickrate/domain/camera/icamera_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/custom_snackbar.dart';
import '../../theme/color_palette.dart';
import 'widgets/bottom_row_widget.dart';

class CameraScreen extends StatefulWidget {
  final CameraViewModel model;
  const CameraScreen({super.key, required this.model});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void initState() {
    widget.model.initCamera();
    super.initState();
  }

  @override
  void dispose() {
    widget.model.disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<CameraState>(
        stream: widget.model.cameraStateStream,
        builder: (context, snapshot) {
          switch (snapshot.data) {
            case CameraState.init:
              return Container(
                color: mainColor,
                height: double.infinity,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              );
            case CameraState.error:
              return const Center(
                child: Text('Error'),
              );
            case CameraState.ready:
              return Column(
                children: [
                  Expanded(
                    child: PreviewWidget(
                      cameraPreview: widget.model.cameraPreview,
                      cameraController: widget.model.cameraController,
                    ),
                  ),
                  Container(
                    color: mainColor,
                    child: BottomRowWidget(
                      recordingDuration: widget.model.recordingDuration,
                      takePhoto: !widget.model.isTakePictureClicked
                          ? () => widget.model.onTakePhotoClicked(
                                showException: (message) =>
                                    showCustomSnackBar(context, message),
                                showPicture: () => _showPicture(context),
                              )
                          : () {},
                      switchCamera: widget.model.onToggleCameraClicked,
                      changeOption: widget.model.onChangeActiveOptionClicked,
                      activeOption: widget.model.currentOption,
                      recordVideo: () {
                        /*
                        => widget.model.onRecordVideoClicked(
                        showException: (message) =>
                            showCustomSnackBar(context, message),
                        showVideo: () {
                          _showVideo(context);
                        },
                      )*/
                      },
                      isRecordVideoClicked: widget.model.isRecording,
                      cameraTask: widget.model.cameraTask,
                    ),
                  ),
                ],
              );
            default:
              const Center(
                child: Text('Something went wrong'),
              );
          }
          return Container();
        },
      ),
    );
  }

  void _showPicture(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: Image.file(
              File(widget.model.imagePath!),
            ),
          ),
          actions: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    onPressed: () {
                      widget.model.onClosePictureClicked();
                    },
                    child: const Text(
                      "CLOSE",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: () {
                      widget.model.onApplyPictureClicked(
                        showSuccess: (message) => showCustomSnackBar(
                            context, message,
                            backgroundColor: Colors.green),
                      );
                    },
                    child: const Text(
                      "APPLY",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }

  /*void _showVideo(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return PopScope(
          onPopInvoked: (didPop) {
            widget.model.disposeVideoController();
          },
          child: AlertDialog(
            content: FutureBuilder(
              future: widget.model.initVideoController(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: VideoPlayer(widget.model.videoPlayerController));
                }
              },
            ),
            actions: [
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      onPressed: () {
                        /*     widget.model.onCloseVideoClicked();*/
                      },
                      child: const Text(
                        "CLOSE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () {
                        /*   widget.model.onApplyVideoClicked(
                          showSuccess: (message) => showCustomSnackBar(
                              context, message,
                              backgroundColor: Colors.green),
                        );*/
                      },
                      child: const Text(
                        "APPLY",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
*/
}
