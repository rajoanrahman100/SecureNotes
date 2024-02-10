import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart' hide FormData, Response;
import 'package:dio/dio.dart';
import 'package:securenotes/core/helper/logger.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class HttpService {
  Dio? _dio;

  static header() => {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-RapidAPI-Key": "a51e85e75emshc3bd6077a361492p164c58jsnf0775666cde7",
        "X-RapidAPI-Host": "task-manager-api3.p.rapidapi.com"
      };

  Future<dynamic> request({required String url, required Method method, params, String? authToken}) async {
    Response response;

    try {
      if (method == Method.POST) {
        response = await _dio!.post(url,
            data: params!,
            options: Options(
              headers: {"Authorization": "Bearer $authToken"},
            ));
      } else if (method == Method.DELETE) {
        response = await _dio!.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio!.patch(url);
      } else {

        response = await _dio!
            .get(url, queryParameters: params, options: Options(headers: {"Authorization": "Bearer $authToken"}));
      }

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 401) {
        //Get.offAll(const SignIn());
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else if (response.statusCode == 422) {
        //return Get.snackbar('Opps', response.data['message']);
      } else {
        throw Exception("Something does went wrong");
      }
    } on SocketException catch (e) {
      logger.e(e);
      Get.snackbar('Opps', "No Internet Connection");
      throw Exception("No Internet Connection");
    } on FormatException catch (e) {
      logger.e(e);
      throw Exception("Bad response format");
    } on DioException catch (e) {
      logger.e(e);
      if (e.type == DioExceptionType.unknown) {
        log("Error Type unknown");

        throw Exception(e);
      } else if (e.type == DioExceptionType.cancel) {
        log("Error Type cancel");
        throw Exception(e);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        log("Error Type timedOut");
        throw Exception(e);
      } else if (e.type == DioExceptionType.receiveTimeout) {
        log("Error Type received timeout");
        throw Exception(e);
      } else if (e.type == DioExceptionType.sendTimeout) {
        log("Error Type send time out");
        throw Exception(e);
      } else if (e.type == DioExceptionType.badResponse) {
        if (e.response?.statusCode == 401) {
          log("Bad Response If");

          //Get.offAll(() => UserAuthenticationLandingScreen());
          throw Exception(e);
        } else {
          //InvalidLoginResponseModel invalidLoginResponseModel = InvalidLoginResponseModel.fromJson(e.response!.data);
          // warningToast(
          //     context: context,
          //     message: "${invalidLoginResponseModel.errorMessage}",
          //     backColor: AppConst.kRed,
          //     position: StyledToastPosition.top);
          log("Bad Response Elseee");
          throw Exception(e);
        }
      }

      throw Exception(e);
    } catch (e) {
      logger.e(e);
      throw Exception("Something went wrong");
    }
  }
}
