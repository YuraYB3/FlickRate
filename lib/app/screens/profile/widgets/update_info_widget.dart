import 'package:flutter/material.dart';

import '../../../../domain/user/i_my_user.dart';
import '../../../common/widgets/cached_image.dart';
import '../../../common/widgets/custom_snackbar.dart';
import '../../../theme/color_palette.dart';

class UpdateInfoWidget extends StatelessWidget {
  UpdateInfoWidget(
      {super.key,
      required this.userData,
      required this.onChangePhotoClicked,
      required this.updateUserNickNameField,
      required this.onChangeUserNickNameClicked});

  final IMyUser userData;
  final Function(Function(String message)) onChangePhotoClicked;
  final Function(String value) updateUserNickNameField;
  final Function(Function(String message)) onChangeUserNickNameClicked;
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
                    onChangePhotoClicked(
                        (message) => showCustomSnackBar(context, message));
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
                        onChangeUserNickNameClicked(
                          (message) {
                            showCustomSnackBar(context, message);
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
    );
  }
}
