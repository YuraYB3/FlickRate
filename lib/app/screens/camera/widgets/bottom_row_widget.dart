import 'package:flutter/material.dart';

class BottomRowWidget extends StatelessWidget {

  final Function() switchCamera;
  final Function() takePhoto;

  const BottomRowWidget({
    super.key, required this.switchCamera, required this.takePhoto,

  });


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(onPressed: switchCamera, icon: const Icon(Icons.switch_camera_rounded, size: 48, color: Colors.white,),),
        IconButton(onPressed: takePhoto, icon: const Icon(Icons.camera, size: 48, color: Colors.white,),)
      ],
    );
  }
}
