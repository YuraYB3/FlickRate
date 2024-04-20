import 'package:camera/camera.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

class PreviewWidget extends StatefulWidget {
  final Widget cameraPreview;
  final ColorsPalette colorsPalette = ColorsPalette();
  final CameraController cameraController;
  PreviewWidget(
      {required this.cameraPreview, super.key, required this.cameraController});

  @override
  State<PreviewWidget> createState() => _PreviewWidgetState();
}

class _PreviewWidgetState extends State<PreviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1 /
          (widget.cameraController.value.aspectRatio *
              MediaQuery.of(context).size.aspectRatio),
      child: widget.cameraPreview,
    );
  }
}
