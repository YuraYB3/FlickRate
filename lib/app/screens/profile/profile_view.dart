import 'package:flickrate/app/common/screens/my_loading_widget.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

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
          widget._model.isEditInfoClicked
              ? IconButton(
                  onPressed: widget._model.onEditInfoButtonClicked,
                  icon: const Icon(Icons.person_4))
              : IconButton(
                  onPressed: widget._model.onEditInfoButtonClicked,
                  icon: const Icon(Icons.edit))
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
                        onChangePhotoClicked: (p0) {
                          widget._model.onChangePhotoClicked(showException: p0);
                        },
                        onChangeUserNickNameClicked: (p0) {
                          widget._model
                              .onChangeUserNickNameClicked(showException: p0);
                        },
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
