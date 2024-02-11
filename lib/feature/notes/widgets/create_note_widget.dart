import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:securenotes/config/notification_service/notification_service.dart';
import 'package:securenotes/core/constants/app_assets.dart';
import 'package:securenotes/core/constants/app_colors.dart';
import 'package:securenotes/core/constants/text_styles.dart';
import 'package:securenotes/core/helper/global_widgets.dart';
import 'package:securenotes/core/helper/validation.dart';
import 'package:securenotes/feature/notes/controller/note_controller.dart';
import 'package:securenotes/feature/notes/model/note_list_data_model.dart';


class CreateNoteBottomSheet extends StatelessWidget {
  CreateNoteBottomSheet(
      {super.key, required this.width, required this.formKey, required this.noteController, this.allowEdit, this.note});

  final double? width;
  final GlobalKey<FormState> formKey;
  final NoteController noteController;
  bool? allowEdit;
  Note? note;

  DateTime _convertTimeOfDayToDateTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  }

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
                  GestureDetector(
                    onTap: () {
                      showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                        log(value!.format(context).toString());
                        DateTime convertedDateTime = _convertTimeOfDayToDateTime(value);
                        print('Converted DateTime: $convertedDateTime');
                        NotificationService().scheduleNotification(
                            title: noteController.titleEditingController.text,
                            body: noteController.descriptionEditingController.text,
                            scheduledNotificationDateTime: convertedDateTime);
                      });
                    },
                    child: Row(
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
                  ),
                  allowEdit == true
                      ? Obx(() => GestureDetector(
                            onTap: () {
                              noteController.changeStatus();
                              print(noteController.noteStatus);
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.kBSDark, width: 2.0),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: noteController.statusComplete.value
                                      ? const Icon(Icons.check, color: AppColors.black, size: 15.0)
                                      : null,
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
                          ))
                      : Container(),
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
                      if (allowEdit == true) {
                        log("NOTE ID ${note!.id}");
                        noteController.updateNote(note!.id!, formData, context);
                      } else {
                        noteController.createNote(formData, context);
                      }
                    }
                  },
                  title: allowEdit == true ? "Update" : "Create",
                  isLoading: noteController.createLoading.value)),
              const Gap(20.0),
              allowEdit == true
                  ? Obx(() => GestureDetector(
                        onTap: () {
                          noteController.deleteNote(note!.id!, context);
                        },
                        child: noteController.deleteLoading.value == true
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.error600,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.delete_forever, color: AppColors.error600, size: 15.0),
                                  const Gap(10.0),
                                  Text(
                                    "Delete the note permanently?",
                                    style: bodySemiBold16.copyWith(color: AppColors.error600),
                                  ),
                                ],
                              ),
                      ))
                  : Container(),
              const Gap(20.0),
            ],
          ),
        ),
      ),
    );
  }
}
