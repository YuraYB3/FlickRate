import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

class PreviewWidget extends StatefulWidget {
  final Widget cameraPreview;
  final ColorsPalette colorsPalette = ColorsPalette();
  PreviewWidget({required this.cameraPreview, super.key});

  @override
  State<PreviewWidget> createState() => _PreviewWidgetState();
}

class _PreviewWidgetState extends State<PreviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          decoration:  BoxDecoration(
            border: Border.all(
                color: widget.colorsPalette.mainColor,
                width: 20
              ),
            ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: AspectRatio(
                  aspectRatio: 9.0 / 16.0,
                  child: widget.cameraPreview),
          ),
        ),
      ),
    );
  }
}