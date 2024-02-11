import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:securenotes/config/network_service/network_service.dart';
import 'package:securenotes/core/constants/app_colors.dart';
import 'package:securenotes/core/helper/logger.dart';
import 'package:securenotes/feature/notes/model/create_note_data_model.dart';
import 'package:securenotes/feature/notes/model/note_list_data_model.dart';

import '../../../core/constants/api_endpoints.dart';

class NoteController extends GetxController {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();

  HttpService httpService = HttpService();
  RxBool createLoading = false.obs;
  RxBool deleteLoading = false.obs;
  Rx<NoteListDataModel> noteListDataModel = NoteListDataModel().obs;
  RxBool statusComplete = false.obs;
  String noteStatus="pendiente";

  changeStatus() {
    statusComplete.value = !statusComplete.value;
    if(statusComplete.value==true){
      noteStatus="completada";
    }else{
      noteStatus="pendiente";
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    httpService.init();
    super.onInit();
  }

  Future<void> getCreatedNote() async {
    try {
      final result = await httpService.request(url: ApiEndPoints.baseUrl, method: Method.GET);

      if (result != null) {
        if (result is Response) {
          var data = result.data;
          logger.d(result.data);
          if (result.statusCode == 200) {
            noteListDataModel.value = NoteListDataModel.fromJson(result.data);
          }
        } else {}
      }
    } finally {}
  }

  Future<void> createNote(formData, context) async {
    try {
      createLoading(true);
      final result =
          await httpService.request(url: ApiEndPoints.baseUrl, method: Method.POST, params: formData, context: context);

      if (result != null) {
        if (result is Response) {
          var data = result.data;
          logger.d(result.data);
          if (result.statusCode == 200 || result.statusCode == 201) {
            CreateNoteModel createNoteModel = CreateNoteModel.fromJson(result.data);
            createLoading(false);
            Get.back();
            //
            getCreatedNote();
            Get.snackbar('Success', "${createNoteModel.message}",
                backgroundColor: AppColors.success600, colorText: AppColors.white);
          }
        } else {
          createLoading(false);
        }
      }
    } finally {
      createLoading(false);
    }
  }

  Future<void> updateNote(noteID,formData, context) async {

    print("${ApiEndPoints.baseUrl}/$noteID");

    try {
      createLoading(true);
      final result =
      await httpService.request(url: "${ApiEndPoints.baseUrl}$noteID", method: Method.PUT, params: formData, context: context);

      if (result != null) {
        if (result is Response) {
          var data = result.data;
          logger.d(result.data);
          if (result.statusCode == 200 || result.statusCode == 201) {
            CreateNoteModel createNoteModel = CreateNoteModel.fromJson(result.data);
            createLoading(false);
            statusComplete.value=false;
            Get.back();
            //
            getCreatedNote();
            Get.snackbar('Success', "${createNoteModel.message}",
                backgroundColor: AppColors.success600, colorText: AppColors.white);
          }
        } else {
          createLoading(false);
        }
      }
    } finally {
      createLoading(false);
    }
  }

  Future<void> deleteNote(noteID, context) async {
    try {
      deleteLoading(true);
      final result =
      await httpService.request(url: "${ApiEndPoints.baseUrl}$noteID", method: Method.DELETE,context: context);

      if (result != null) {
        if (result is Response) {
          logger.d(result.data);
          if (result.statusCode == 200 || result.statusCode == 201) {
            CreateNoteModel createNoteModel = CreateNoteModel.fromJson(result.data);
            deleteLoading(false);
            Get.back();
            //
            getCreatedNote();
            Get.snackbar('Success', "${createNoteModel.message}",
                backgroundColor: AppColors.success600, colorText: AppColors.white);
          }
        } else {
          deleteLoading(false);
        }
      }
    } finally {
      deleteLoading(false);
    }
  }
}
