import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:securenotes/config/route/app_pages.dart';
import 'package:securenotes/core/constants/app_colors.dart';
import 'package:securenotes/core/constants/text_styles.dart';
import 'package:securenotes/core/helper/local_storage.dart';
import 'package:securenotes/feature/google_signin/controller/google_sign_in_controller.dart';
import 'package:securenotes/feature/google_signin/widget/cache_image_widget.dart';

class SignOutMenu extends StatelessWidget {
  const SignOutMenu({
    super.key,
    required this.googleSignInController,
  });

  final GoogleSignInController googleSignInController;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      surfaceTintColor: AppColors.white,
      onSelected: (value) {
        if (value == 'signOut') {
          // Handle sign-out logic
          googleSignInController.signOut().then((value) {
            Get.offAllNamed(Routes.singIn);
          });
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'signOut',
            textStyle: bodyRegular14,
            child: Text(
              'Sign Out',
            ),
          ),
        ];
      },
      child: CacheImageWidget(
        height: 30,
        width: 30,
        imageUrl: LocalStorage.getPhotoUrl(),
      ),
    );
  }
}