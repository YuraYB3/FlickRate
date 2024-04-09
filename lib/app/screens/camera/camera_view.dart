import 'dart:io';

import 'package:flickrate/app/screens/camera/camera_view_model.dart';
import 'package:flickrate/app/screens/camera/widgets/preview_widget.dart';
import 'package:flickrate/domain/camera/icamera_service.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/custom_snackbar.dart';
import 'widgets/bottom_row_widget.dart';

class CameraView extends StatefulWidget {
  final CameraViewModel model;
  final ColorsPalette colorsPalette = ColorsPalette();
  CameraView({super.key, required this.model});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  void initState() {
    widget.model.init();
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
        backgroundColor: widget.colorsPalette.mainColor,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<CameraState>(stream: widget.model.cameraStateStream,  builder: (context, snapshot) {
        switch (snapshot.data) {
          case CameraState.init:
            return  Container(
              color: widget.colorsPalette.mainColor,
              height: double.infinity,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          case CameraState.error:
            return const Center(
              child: Text(
                'Error'
              ),
            );
          case CameraState.ready:
          return  Column(
            children: [
              PreviewWidget(cameraPreview: widget.model.cameraPreview), 
              Container(
                color: widget.colorsPalette.mainColor,
                child: BottomRowWidget(takePhoto: () => widget.model.onTakePhotoClicked(showException: (message) => showCustomSnackBar(context, message), showPicture: () => _showPicture(context),),switchCamera: widget.model.onToggleCameraClicked,),
              )
            ],
          );
          default: const Center(
            child: Text(
              'Something went wrong'
            ),
          );
        }
        return Container();
      },
    ),
  );
  }
  void _showPicture(BuildContext context) {
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Image.file(File(widget.model.imagePath!), 
          ),),
        actions: [
         SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            TextButton(
            onPressed: () {
              widget.model.onClosePictureClicked();
            },
            child: const Text("Close", style: TextStyle(
              color: Colors.red
            ),),  
          ),
          TextButton(
            onPressed: () {
              widget.model.onApplyPictureClicked(showSuccess: (message) => showCustomSnackBar(context, message, backgroundColor: Colors.green),);
            },
            child: const Text("Apply", style: TextStyle(
              color: Colors.green
            ),),)
            ],
          ),
         )
        ],
      );
    },
  );
  }
}
  
