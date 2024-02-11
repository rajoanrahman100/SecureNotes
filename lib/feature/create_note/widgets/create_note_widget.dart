import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:securenotes/core/constants/app_assets.dart';
import 'package:securenotes/core/constants/app_colors.dart';
import 'package:securenotes/core/constants/text_styles.dart';
import 'package:securenotes/core/helper/global_widgets.dart';
import 'package:securenotes/core/helper/validation.dart';
import 'package:securenotes/feature/create_note/controller/note_controller.dart';

class CreateNoteWidget extends StatelessWidget {
  CreateNoteWidget({
    super.key,
    required this.width,
  });

  final double? width;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    NoteController noteController = Get.find();

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 30.0, right: 20.0, top: 10.0),
      child: GestureDetector(
        onTap: () {
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
                return Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    width: width,
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "New Note",
                            style: bodySemiBold16.copyWith(color: AppColors.kBSDark),
                          ),
                          const Gap(20.0),
                          TextFieldWidget(
                            hintTex: "Title",
                            textEditingController: noteController.titleEditingController,
                            enableColor: AppColors.white,
                            validation: (String? value) {
                              return Validator.validateNoteTitle(value!);
                            },
                          ),
                          const Gap(15.0),
                          TextFieldWidget(
                            hintTex: "Content",
                            textEditingController: noteController.descriptionEditingController,
                            enableColor: AppColors.white,
                            minLine: 3,
                            maxLine: 6,
                            validation: (String? value) {
                              return Validator.validateNoteContent(value!);
                            },
                          ),
                          const Gap(20.0),
                          Obx(() => PrimaryButtonWidget(
                              width: width!,
                              callback: () {
                                if (formKey.currentState == null || formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  var formData = {
                                    "title": noteController.titleEditingController.text,
                                    "description": noteController.descriptionEditingController.text,
                                    "status": "pendiente"
                                  };
                                  noteController.createNote(formData, context);
                                }
                              },
                              title: "Create",
                              isLoading: noteController.createLoading.value)),
                          const Gap(20.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.add_alert,
                                color: AppColors.kBSDark,
                                size: 20.0,
                              ),
                              const Gap(10.0),
                              Text(
                                "Remind me",
                                style: bodySemiBold16.copyWith(
                                  color: AppColors.kBSDark,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: 20.0,
                width: 20.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: AppColors.kBSDark, borderRadius: BorderRadius.circular(5.0)),
                child: const Icon(
                  Icons.add,
                  color: AppColors.white,
                  size: 18.0,
                )),
            const Gap(10.0),
            Expanded(
                child: Text(
              "New note",
              style: bodySemiBold16.copyWith(color: AppColors.kBSDark),
            )),
            Image.asset(
              AppAssets.noteImage,
              height: 20,
              width: 20,
              color: AppColors.kBSDark,
            ),
          ],
        ),
      ),
    );
  }
}
