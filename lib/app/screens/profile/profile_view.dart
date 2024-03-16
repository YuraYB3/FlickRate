import 'package:flickrate/domain/user/i_my_user.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/custom_snackbar.dart';
import '../../common/widgets/my_elevated_button.dart';
import '../../common/widgets/my_error_widget.dart';
import '../../common/widgets/my_loading_widget.dart';
import 'profile_view_model.dart';

class ProfileView extends StatelessWidget {
  final ProfileViewModel _model;
  const ProfileView({required ProfileViewModel model, super.key})
      : _model = model;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<IMyUser>(
      stream: _model.userStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const MyErrorWidget();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MyLoadingWidget();
        }
        final userData = snapshot.data!;
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
                  CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(userData.userProfileImage),
                  ),
                  Positioned(
                      bottom: -10,
                      left: 60,
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
      },
    );
  }
}
