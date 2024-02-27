import 'package:flickrate/app/common/widgets/my_elevated_button.dart';
import 'package:flickrate/app/screens/profile/profile_view_model.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  final ProfileViewModel _model;
  const ProfileView({required ProfileViewModel model, super.key})
      : _model = model;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyElevatedButton(
            title: 'Log out',
            onButtonPressed: () {
              widget._model.onLogOutButtonPressed();
            }),
      ),
    );
  }
}
