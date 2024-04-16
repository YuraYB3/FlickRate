import 'package:flickrate/app/common/screens/my_loading_widget.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/custom_snackbar.dart';
import 'profile_view_model.dart';
import 'widgets/actions_info_widget.dart';
import 'widgets/log_out_button.dart';
import 'widgets/update_info_widget.dart';
import 'widgets/user_info_widget.dart';

class ProfileView extends StatefulWidget {
  final ProfileViewModel _model;

  const ProfileView({required ProfileViewModel model, super.key})
      : _model = model;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  ColorsPalette colorsPalette = ColorsPalette();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorsPalette.mainColor,
        actions: [
          IconButton(
            onPressed: () => widget._model.onVideoCameraClicked(
              showException: (message) => showCustomSnackBar(context, message),
            ),
            icon: const Icon(
              Icons.videocam,
              color: Colors.white,
            ),
          ),
          widget._model.isEditInfoClicked
              ? IconButton(
                  onPressed: widget._model.onEditInfoButtonClicked,
                  icon: const Icon(
                    Icons.person_4,
                    color: Colors.white,
                  ),
                )
              : IconButton(
                  onPressed: widget._model.onEditInfoButtonClicked,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
        ],
      ),
      body: widget._model.profileViewState == ProfileViewState.loadingInfo
          ? MyLoadingScreen()
          : StreamBuilder(
              stream: widget._model.userStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return MyLoadingScreen();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return MyLoadingScreen();
                }
                final userData = snapshot.data!;
                return Column(
                  children: [
                    const Divider(
                      color: Colors.grey,
                    ),
                    if (!widget._model.isEditInfoClicked)
                      UserInfoWidget(userData: userData)
                    else
                      UpdateInfoWidget(
                        userData: userData,
                        updateUserNickNameField: (value) {
                          widget._model.updateUserNickNameField(value);
                        },
                        onChangePhotoByGalleryClicked: () =>
                            widget._model.onChoosePhotoFromGalleryClicked(
                          showException: (message) =>
                              showCustomSnackBar(context, message),
                          showSuccess: (message) => showCustomSnackBar(
                              context, message,
                              backgroundColor: Colors.green),
                        ),
                        onChangeUserNickNameClicked: () =>
                            widget._model.onChangeUserNickNameClicked(
                          showException: (message) =>
                              showCustomSnackBar(context, message),
                        ),
                        onChangePhotoByCameraClicked: () =>
                            widget._model.onMadePhotoByCameraClicked(
                          showException: (message) =>
                              showCustomSnackBar(context, message),
                        ),
                      ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ActionsInfoWidget(
                          reviewCount: userData.reviewCount.toString(),
                          userLikes: userData.userLikes.toString()),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    LogOutButton(
                        onLogOutButtonPressed:
                            widget._model.onLogOutButtonPressed),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Expanded(child: Container()),
                  ],
                );
              },
            ),
    );
  }
}
