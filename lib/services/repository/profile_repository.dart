import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/models/user_model/user_model.dart';
import 'package:el_mago/services/api/api_services.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ProfileRepository {
  // The private constructor and static instance have been removed.
  // GetX will now handle the instantiation and singleton lifecycle.

  final ApiServices apiServices = ApiServices.instance;

  Future<bool> updateUserProfile({
    required String name,
    required String address,
    required String phone,
    required String image,
  }) async {
    try {
      FormData formDataMap = FormData.fromMap({
        "data": jsonEncode({"name": name, "address": address, "phone": phone}),
      });

      if (image.isNotEmpty) {
        try {
          final file = File(image);
          if (await file.exists()) {
            String fileName = file.path.split('/').last;
            var mimeType = lookupMimeType(file.path);

            formDataMap.files.add(
              MapEntry(
                "image",
                await MultipartFile.fromFile(
                  file.path,
                  filename: fileName,
                  contentType: MediaType.parse(
                    mimeType ?? 'application/octet-stream',
                  ),
                ),
              ),
            );
          } else {
            AppPrint.appLog("Image file does not exist at path: $image");
          }
        } catch (e) {
          AppPrint.appError("Error processing image file: $e");
        }
      }

      var response = await apiServices.apiPatchServices(
        url: AppApiEndPoint.instance.profile,
        body: formDataMap,
      );

      if (response != null) {
        AppPrint.appLog("✅ Profile updated successfully");
        return true;
      } else {
        AppPrint.appLog("❌ Profile update failed: Response is null");
        return false;
      }
    } catch (e) {
      AppPrint.appError(e, title: "updateUserProfile");
      return false;
    }
  }

  Future<UserModelData?> getProfileData() async {
    try {
      var response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.profile,
      );
      if (response != null) {
        if (response["data"] != null && response["data"] is Map) {
          return UserModelData.fromJson(response["data"]);
        }
      } else {
        AppPrint.appLog("getProfileData response null");
        return null;
      }
    } catch (e) {
      AppPrint.appError(e, title: "getProfileData");
    }
    return null;
  }
}
