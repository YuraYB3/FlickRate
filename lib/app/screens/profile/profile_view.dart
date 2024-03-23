import 'package:flickrate/app/common/screens/my_loading_widget.dart';
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
      child: _model.profileViewState == ProfileViewState.loadingInfo
          ? MyLoadingScreen()
          : StreamBuilder(
              stream: _model.userStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return MyLoadingScreen();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return MyLoadingScreen();
                }
                final userData = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CachedImageWidget(
                          imageUrl: userData.userProfileImage,
                          imageSize: 130,
                          shape: BoxShape.circle,
                        ),
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
                        width: MediaQuery.of(context).size.width * 0.6,
                        title: 'Log out',
                        onButtonPressed: () {
                          _model.onLogOutButtonPressed();
                        }),
                  ],
                );
              },
            ),
    ));
  }
}
