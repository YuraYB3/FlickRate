import 'package:flickrate/app/common/screens/my_loading_widget.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/cached_image.dart';
import '../../common/widgets/custom_snackbar.dart';
import 'profile_view_model.dart';

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
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CachedImageWidget(
                              imageUrl: userData.userProfileImage,
                              height: 80,
                              width: 80,
                              shape: BoxShape.circle,
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData.userName,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                CachedImageWidget(
                                  imageUrl: userData.userProfileImage,
                                  height: 80,
                                  width: 80,
                                  shape: BoxShape.circle,
                                ),
                                Positioned(
                                  bottom: -10,
                                  left: 45,
                                  child: IconButton(
                                    onPressed: () {
                                      widget._model.onChangePhotoClicked(
                                        showException: (message) =>
                                            showCustomSnackBar(
                                                context, message),
                                      );
                                    },
                                    icon: const Icon(Icons.add_a_photo),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                          ),
                                          child: TextField(
                                              onChanged: (value) {
                                                widget._model
                                                    .updateUserNickNameField(
                                                        value);
                                              },
                                              maxLength: 13,
                                              decoration: InputDecoration(
                                                labelStyle: TextStyle(
                                                    color: colorsPalette
                                                        .mainColor),
                                                hintText: 'Enter nickname',
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: colorsPalette
                                                                .mainColor)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: colorsPalette
                                                          .mainColor),
                                                ),
                                                counterText: '',
                                              )),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          widget._model
                                              .onChangeUserNickNameClicked(
                                            showException: (message) {
                                              showCustomSnackBar(
                                                  context, message);
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.done,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                userData.reviewCount.toString(),
                                style: TextStyle(
                                    color: colorsPalette.mainColor,
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('Reviews',
                                  style: TextStyle(
                                      color: colorsPalette.secondColor)),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                userData.userLikes.toString(),
                                style: TextStyle(
                                    color: colorsPalette.mainColor,
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Likes',
                                style:
                                    TextStyle(color: colorsPalette.secondColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: GestureDetector(
                        onTap: () {
                          widget._model.onLogOutButtonPressed();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.red,
                              size: 18,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Log out',
                              style: TextStyle(color: Colors.red, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
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
