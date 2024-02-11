import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:securenotes/core/constants/app_assets.dart';
import 'package:securenotes/core/constants/app_colors.dart';
import 'package:securenotes/core/constants/text_styles.dart';
import 'package:securenotes/core/helper/global_widgets.dart';
import 'package:securenotes/core/helper/validation.dart';
import 'package:securenotes/feature/notes/controller/note_controller.dart';
import 'package:securenotes/feature/notes/model/note_list_data_model.dart';

class CreateNoteWidget extends StatelessWidget {
  CreateNoteWidget({super.key, required this.width,});

  final double? width;
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    NoteController noteController = Get.find();

    return GestureDetector(
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
              return CreateNoteBottomSheet(width: width, formKey: formKey, noteController: noteController);
            });
      },
      child: Container(
        padding: const EdgeInsets.only(left: 20.0, bottom: 30.0, right: 20.0, top: 30.0),
        color: AppColors.surfaceColor,
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

class CreateNoteBottomSheet extends StatelessWidget {
   CreateNoteBottomSheet({
    super.key,
    required this.width,
    required this.formKey,
    required this.noteController,
    this.allowEdit, this.note
  });

  final double? width;
  final GlobalKey<FormState> formKey;
  final NoteController noteController;
  bool? allowEdit;
  Note? note;

  @override
  Widget build(BuildContext context) {



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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  ),
                  allowEdit==true? Obx(()=>GestureDetector(
                    onTap: (){
                      noteController.changeStatus();
                      print(noteController.noteStatus);
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.kBSDark, width: 2.0),borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: noteController.statusComplete.value?const Icon(Icons.check, color: AppColors.black, size: 15.0):null,
                        ),
                        const Gap(10.0),
                        Text(
                          "Completed",
                          style: bodySemiBold16.copyWith(
                            color: AppColors.kBSDark,
                          ),
                        ),
                      ],
                    ),
                  )):Container(),

                ],
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
                        "status": noteController.noteStatus
                      };
                      log(formData.toString());
                      if (allowEdit == true){
                        log("NOTE ID ${note!.id}");
                        noteController.updateNote(note!.id!,formData, context);
                      }else{
                        noteController.createNote(formData, context);
                      }

                    }
                  },
                  title: allowEdit == true?"Update":"Create",
                  isLoading: noteController.createLoading.value)),
              const Gap(20.0),
              allowEdit==true?Obx(()=>GestureDetector(
                onTap: (){
                  noteController.deleteNote(note!.id!, context);
                },
                child: noteController.deleteLoading.value==true?const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.error600,
                  ),
                ):Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.delete_forever, color: AppColors.error600, size: 15.0),
                    const Gap(10.0),
                    Text(
                      "Delete the note permanently?",
                      style: bodySemiBold16.copyWith(
                          color: AppColors.error600
                      ),
                    ),
                  ],
                ),
              )):Container(),
              const Gap(20.0),
            ],
          ),
        ),
      ),
    );
  }
}
