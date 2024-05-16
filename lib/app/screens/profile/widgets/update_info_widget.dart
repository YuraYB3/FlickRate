import 'package:flutter/material.dart';

import '../../../../domain/user/i_my_user.dart';
import '../../../common/widgets/cached_image.dart';
import '../../../common/widgets/custom_snackbar.dart';
import '../../../theme/color_palette.dart';

class UpdateInfoWidget extends StatelessWidget {
  const UpdateInfoWidget(
      {super.key,
      required this.userData,
      required this.onChangePhotoByGalleryClicked,
      required this.onChangePhotoByCameraClicked,
      required this.updateUserNickNameField,
      required this.onChangeUserNickNameClicked});

  final IMyUser userData;
  final Function onChangePhotoByGalleryClicked;
  final Function onChangePhotoByCameraClicked;
  final Function updateUserNickNameField;
  final Function onChangeUserNickNameClicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                left: 40,
                child: IconButton(
                  onPressed: () {
                    showCustomModelSnackBar(
                        context,
                        onChangePhotoByGalleryClicked,
                        onChangePhotoByCameraClicked);
                  },
                  icon: const Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
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
                width: MediaQuery.of(context).size.width * 0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          onChanged: (value) {
                            updateUserNickNameField(value);
                          },
                          maxLength: 15,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: mainColor),
                            hintText: 'Enter nickname',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            counterText: '',
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        onChangeUserNickNameClicked(
                            showException: (message) =>
                                showCustomSnackBar(context, message));
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
    );
  }
}

void showCustomModelSnackBar(
    BuildContext context,
    Function onChangePhotoFromGalleryClicked,
    Function onChangePhotoByCameraClicked) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height / 5.2,
        margin: const EdgeInsets.only(top: 8.0),
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  child: const Column(
                    children: [
                      Icon(Icons.image, size: 60, color: mainColor),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Gallery",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: secondaryColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    onChangePhotoFromGalleryClicked(
                        showException: (message) =>
                            showCustomSnackBar(context, message),
                        showSuccess: (message) => showCustomSnackBar(
                            context, message,
                            backgroundColor: Colors.green));
                  },
                ),
              ),
              Expanded(
                child: InkWell(
                  child: const Column(
                    children: [
                      Icon(Icons.camera, size: 60, color: mainColor),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Camera",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: secondaryColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    onChangePhotoByCameraClicked(
                        showException: (message) =>
                            showCustomSnackBar(context, message));
                  },
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
