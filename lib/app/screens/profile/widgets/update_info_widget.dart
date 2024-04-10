import 'package:flutter/material.dart';

import '../../../../domain/user/i_my_user.dart';
import '../../../common/widgets/cached_image.dart';
import '../../../theme/color_palette.dart';

class UpdateInfoWidget extends StatelessWidget {
  UpdateInfoWidget(
      {super.key,
      required this.userData,
      required this.onChangePhotoByGalleryClicked,
      required this.onChangePhotoByCameraClicked,
      required this.updateUserNickNameField,
      required this.onChangeUserNickNameClicked});

  final IMyUser userData;
  final Function() onChangePhotoByGalleryClicked;
  final Function() onChangePhotoByCameraClicked;
  final Function(String value) updateUserNickNameField;
  final Function() onChangeUserNickNameClicked;
  final ColorsPalette colorsPalette = ColorsPalette();

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
                left: 45,
                child: IconButton(
                  onPressed: () {
                    showCustomModelSnackBar(
                        context,
                        colorsPalette,
                        onChangePhotoByGalleryClicked,
                        onChangePhotoByCameraClicked);
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
                width: MediaQuery.of(context).size.width * 0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: TextField(
                            onChanged: (value) {
                              updateUserNickNameField(value);
                            },
                            maxLength: 13,
                            decoration: InputDecoration(
                              labelStyle:
                                  TextStyle(color: colorsPalette.mainColor),
                              hintText: 'Enter nickname',
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: colorsPalette.mainColor)),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: colorsPalette.mainColor),
                              ),
                              counterText: '',
                            )),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        onChangeUserNickNameClicked();
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
    ColorsPalette colorsPalette,
    Function() onChangePhotoFromGalleryClicked,
    Function() onChangePhotoByCameraClicked) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Card(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5.2,
          margin: const EdgeInsets.only(top: 8.0),
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  child: Column(
                    children: [
                      Icon(Icons.image,
                          size: 60, color: colorsPalette.mainColor),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Gallery",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, color: colorsPalette.secondColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    onChangePhotoFromGalleryClicked();
                  },
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Column(
                    children: [
                      Icon(Icons.camera,
                          size: 60, color: colorsPalette.mainColor),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Camera",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, color: colorsPalette.secondColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    onChangePhotoByCameraClicked();
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
