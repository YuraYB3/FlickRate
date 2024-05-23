import 'package:flickrate/app/common/widgets/my_loading_widget.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

import 'profile_view_model.dart';
import 'widgets/actions_info_widget.dart';
import 'widgets/log_out_button.dart';
import 'widgets/update_info_widget.dart';
import 'widgets/user_info_widget.dart';

class ProfileScreen extends StatefulWidget {
  final ProfileViewModel _model;

  const ProfileScreen({required ProfileViewModel model, super.key})
      : _model = model;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget._model.profileViewState == ProfileViewState.loadingInfo
          ? const MyLoadingScreen()
          : StreamBuilder(
              stream: widget._model.userStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const MyLoadingScreen();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const MyLoadingScreen();
                }
                final userData = snapshot.data!;
                return Column(
                  children: [
                    const Expanded(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    if (!widget._model.isEditInfoClicked)
                      SafeArea(
                        bottom: false,
                        child: UserInfoWidget(
                          userName: userData.userName,
                          userProfileImage: userData.userProfileImage,
                        ),
                      )
                    else
                      SafeArea(
                        bottom: false,
                        child: UpdateInfoWidget(
                            userData: userData,
                            updateUserNickNameField:
                                widget._model.updateUserNickNameField,
                            onChangePhotoByGalleryClicked:
                                widget._model.onChoosePhotoFromGalleryClicked,
                            onChangeUserNickNameClicked:
                                widget._model.onChangeUserNickNameClicked,
                            onChangePhotoByCameraClicked:
                                widget._model.onMadePhotoByCameraClicked),
                      ),
                    widget._model.isEditInfoClicked
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: ActionsInfoWidget(
                              reviewCount: userData.reviewCount.toString(),
                            ),
                          ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Divider(
                      color: mainColor,
                    ),
                    ProfileCustomButton(
                        onButtonPressed: () {},
                        icon: Icons.favorite,
                        buttonText: 'Favorite'),
                    const Divider(
                      color: mainColor,
                    ),
                    ProfileCustomButton(
                        onButtonPressed: widget._model.onChangeLanguageTap,
                        icon: Icons.language,
                        buttonText: 'Change language'),
                    const Divider(
                      color: mainColor,
                    ),
                    ProfileCustomButton(
                        onButtonPressed: widget._model.onEditInfoButtonClicked,
                        icon: Icons.edit,
                        buttonText: 'Edit profile'),
                    const Divider(
                      color: mainColor,
                    ),
                    SafeArea(
                      top: false,
                      bottom: false,
                      child: ProfileCustomButton(
                          buttonText: 'Вийти',
                          icon: Icons.logout,
                          onButtonPressed: widget._model.onLogOutButtonPressed),
                    ),
                    const SafeArea(
                      top: false,
                      bottom: true,
                      child: Divider(
                        color: mainColor,
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
