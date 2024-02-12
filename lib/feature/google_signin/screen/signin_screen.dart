import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:securenotes/config/route/app_pages.dart';
import 'package:securenotes/core/constants/app_assets.dart';
import 'package:securenotes/core/constants/app_colors.dart';
import 'package:securenotes/core/constants/text_styles.dart';
import 'package:securenotes/core/helper/global_widgets.dart';
import 'package:securenotes/core/helper/local_storage.dart';
import 'package:securenotes/core/helper/size_helper.dart';
import 'package:securenotes/core/resources/secure_storage.dart';
import 'package:securenotes/feature/google_signin/controller/google_sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.initialize(context);
    double? width = AppSize.screenWidth;
    double? height = AppSize.screenHeight;

    GoogleSignInController googleSignInController = Get.find();

    return Scaffold(
      backgroundColor: AppColors.surfaceColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: AppColors.surfaceColor,
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(100.0),
                Image.asset(
                  AppAssets.noteImage,
                  height: 70,
                  width: 70,
                ),
                const Gap(20.0),
                Text(
                  "SecureNotes",
                  style: headingBold28.copyWith(
                      color: AppColors.kBSDark,
                      fontFamily: AppAssets.robotoSlabFontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0),
                ),
                Text(
                  "Your Thoughts, Fortified",
                  style: bodyRegular12.copyWith(color: AppColors.kBSDark, fontFamily: AppAssets.poppinsFontFamily),
                ),
              ],
            )),
            Expanded(
              child: Column(
                children: [
                  Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: MaterialButton(
                          onPressed: () {


                            //Calling Google Authentication
                            googleSignInController.googleAuthentication().then((userCredential) {


                              //Checking if user credential is not null and save necessary data
                              if (userCredential != null) {
                                googleSignInController.googleUserCredential.value = userCredential;
                                SecureStorage().writeSecureData(AppAssets.keyUserName, userCredential.user!.email!);
                                LocalStorage.saveUserName(userCredential.user!.displayName!);
                                LocalStorage.savePhotoUrl(userCredential.user!.photoURL!);

                                //Passing necessary data to home page through arguments
                                Get.toNamed(Routes.homePage, arguments: {
                                  "arg1": googleSignInController.showDialog.value,
                                  "arg2": googleSignInController.googleUserCredential.value?.user?.photoURL,
                                  "arg3": googleSignInController.googleUserCredential.value?.user?.displayName,
                                });
                              } else {
                                print("NULL");
                              }
                            });
                          },
                          height: 50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          splashColor: AppColors.gray400,
                          color: AppColors.kBSDark,
                          child: googleSignInController.isLoading.value
                              ? const ButtonLoader()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppAssets.googleImage,
                                      height: 20,
                                      width: 20,
                                      color: AppColors.white,
                                    ),
                                    const Gap(10.0),
                                    Text("Continue with Google", style: bodyMedium16.copyWith(color: AppColors.white))
                                  ],
                                ),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
