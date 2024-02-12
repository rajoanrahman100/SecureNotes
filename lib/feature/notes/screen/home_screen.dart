import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:securenotes/core/constants/app_assets.dart';
import 'package:securenotes/core/constants/app_colors.dart';
import 'package:securenotes/core/constants/text_styles.dart';
import 'package:securenotes/core/helper/global_widgets.dart';
import 'package:securenotes/core/helper/size_helper.dart';
import 'package:securenotes/core/resources/secure_storage.dart';
import 'package:securenotes/feature/google_signin/controller/google_sign_in_controller.dart';
import 'package:securenotes/feature/google_signin/widget/welcome_dialog.dart';
import 'package:securenotes/feature/notes/widgets/create_note_widget.dart';
import 'package:securenotes/feature/notes/widgets/sign_out_menu_widget.dart';

import '../controller/note_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleSignInController googleSignInController = Get.find<GoogleSignInController>();
  NoteController noteController = Get.find();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Receiving arguments
    var arguments = Get.arguments;

    noteController.getCreatedNote();

    // Showing the welcome dialog
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
    AppSize.initialize(context);
    double? width = AppSize.screenWidth;
    double? height = AppSize.screenHeight;

    return Scaffold(
      backgroundColor: AppColors.surfaceColor,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [

          //Showing the sign out menu
          SignOutMenu(googleSignInController: googleSignInController),


          const Gap(10.0)

        ],
        title: Text(
          "Notes",
          style: bodyMedium16.copyWith(color: AppColors.kBSDark),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
            height: height,
            width: width,
            child: Obx(() => noteController.noteListDataModel.value.data == null
                ? loaderWidget()
                : ListView.separated(
                    itemCount: noteController.noteListDataModel.value.data!.length,
                    itemBuilder: (_, index) {
                      var data = noteController.noteListDataModel.value.data![index];
                      return GestureDetector(
                        onTap: () {
                          noteController.titleEditingController.text = data.title ?? "";
                          noteController.descriptionEditingController.text = data.description ?? "";

                          showModalBottomSheet(
                                  context: context,
                                  isDismissible: true,
                                  isScrollControlled: true,
                                  backgroundColor: AppColors.surfaceColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      12,
                                    ),
                                    topRight: Radius.circular(
                                      12,
                                    ),
                                  )),
                                  builder: (context) {
                                    return CreateNoteBottomSheet(
                                        width: width,
                                        formKey: formKey,
                                        noteController: noteController,
                                        allowEdit: true,
                                        note: data);
                                  });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.gray50,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${data.title}",
                                      style: bodySemiBold14.copyWith(color: AppColors.kBSDark),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          color: data.status == "completada"
                                              ? AppColors.success600
                                              : AppColors.warning600),
                                      child: Text(
                                        data.status == "completada" ? "Completed" : "Pending",
                                        style: bodyRegular12.copyWith(color: AppColors.white, fontSize: 10.0),
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(10.0),
                                ReadMoreText(
                                  "${data.description}",
                                  trimLines: 3,
                                  colorClickableText: AppColors.gray500,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: ' Show more',
                                  trimExpandedText: ' Show less',
                                  style: bodyRegular14.copyWith(color: AppColors.kBSDark),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Gap(15.0);
                    },
                  ))
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {

          //Showing the secured data (user email)
          /*SecureStorage().readSecureData(AppAssets.keyUserName).then((value) {
            log("Show secure data $value");
          });*/

          //Showing note creation bottom sheet
          noteController.titleEditingController.clear();
          noteController.descriptionEditingController.clear();
          showModalBottomSheet(
              context: context,
              isDismissible: true,
              isScrollControlled: true,
              backgroundColor: AppColors.surfaceColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  12,
                ),
                topRight: Radius.circular(
                  12,
                ),
              )),
              builder: (context) {
                return CreateNoteBottomSheet(width: width, formKey: formKey, noteController: noteController);
              });
        },
        icon: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
        label: Text(
          'New note',
          style: bodySemiBold14.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.kBSDark,
      ),
    );
  }
}
