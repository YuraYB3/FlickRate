import 'package:flutter/material.dart';

import '../../common/widgets/cached_image.dart';
import '../../common/widgets/custom_snackbar.dart';
import '../../common/widgets/my_elevated_button.dart';
import 'profile_view_model.dart';

class ProfileView extends StatelessWidget {
  final ProfileViewModel _model;
  const ProfileView({required ProfileViewModel model, super.key})
      : _model = model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              _model.imgURL != ''
                  ? CachedImageWidget(
                      imageUrl: _model.imgURL,
                      imageSize: 130,
                      shape: BoxShape.circle,
                    )
                  : const CircularProgressIndicator(),
              Positioned(
                  bottom: -10,
                  left: 90,
                  child: IconButton(
                      onPressed: () {
                        _model.onChangePhotoClicked(
                          showException: (message) =>
                              showCustomSnackBar(context, message),
                        );
                      },
                      icon: const Icon(Icons.add_a_photo)))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          MyElevatedButton(
              title: 'Log out',
              onButtonPressed: () {
                _model.onLogOutButtonPressed();
              }),
        ],
      ),
    ));
  }
}
