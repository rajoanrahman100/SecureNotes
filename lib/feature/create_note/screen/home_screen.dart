import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:securenotes/config/route/app_pages.dart';
import 'package:securenotes/core/constants/app_colors.dart';
import 'package:securenotes/core/constants/text_styles.dart';
import 'package:securenotes/core/helper/global_widgets.dart';
import 'package:securenotes/core/helper/local_storage.dart';
import 'package:securenotes/feature/google_signin/controller/google_sign_in_controller.dart';
import 'package:securenotes/feature/google_signin/widget/cache_image_widget.dart';
import 'package:securenotes/feature/google_signin/widget/welcome_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleSignInController googleSignInController = Get.find<GoogleSignInController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var arguments = Get.arguments;
    if (arguments != null) {
      log("Argument Value ${arguments["arg1"]} and ${arguments["arg2"]}");

      arguments["arg1"] == true
          ? Future.delayed(const Duration(seconds: 1), () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return WelcomeDialog(
                      photoUrl: arguments["arg2"],
                      userName: arguments["arg3"],
                    );
                  });
            })
          : null;
    } else {
      log("Argument Null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceColor,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        elevation: 0.0,
        actions: [
          PopupMenuButton<String>(
                surfaceTintColor: AppColors.white,
                onSelected: (value) {
                  if (value == 'signOut') {
                    // Handle sign-out logic
                    googleSignInController.signOut().then((value){
                      Get.offAllNamed(Routes.singIn);
                    });
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem<String>(
                      value: 'signOut',
                      textStyle: bodyRegular14,
                      child: Text('Sign Out',),
                    ),
                  ];
                },
                child: CacheImageWidget(
                  height: 30,width: 30,
                  imageUrl: LocalStorage.getPhotoUrl(),
                ),
              ),
          const Gap(10.0)
        ],
        title: Text(
          "Dashboard",
          style: bodyMedium16.copyWith(color: AppColors.kBSDark),
        ),
      ),
    );
  }
}



