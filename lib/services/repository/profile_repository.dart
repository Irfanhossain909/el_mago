
import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/models/user_model/user_model.dart';
import 'package:el_mago/services/api/api_services.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';

class ProfileRepository {
  ProfileRepository._();
  static final ProfileRepository instance = ProfileRepository._();

  final ApiServices apiServices = ApiServices.instance;

  // Future<UserReactionModelData?> getUserReaction ({required String id}) async{
  //   try {
  //     var response = await apiServices.apiGetServices(
  //       "${AppApiEndPoint.instance.getUserReaction}/$id",
  //     );
  //     if (response != null) {
  //       if (response["data"] != null && response["data"] is Map) {
  //         return UserReactionModelData.fromJson(response["data"]);
  //       }
  //     } else {
  //       AppPrint.appLog("getUserReaction response null");
  //       return null;
  //     }
  //   } catch (e) {
  //     AppPrint.appError(e, title: "getUserReaction");
  //   }
  //   return null;
  // }

  // Future<bool> userReaction({
  //   required String uid,
  //   required dynamic value,
  // }) async {
  //   try {
  //     Map<String, dynamic> body = {"user": uid, "isLike": value};
  //     var response = await apiServices.apiPostServices(
  //       url: AppApiEndPoint.instance.userReaction,
  //       body: body,
  //     );

  //     if (response != null) {
  //       return value;
  //     } else {
  //       AppPrint.appError("response is null");
  //     }
  //   } catch (e) {
  //     AppPrint.appError(e, title: "reactPost");
  //   }

  //   return false;
  // }

  // Future<bool> updateUserProfile({
  //   required String name,
  //   required String gender,
  //   required String birthday,
  //   required String relationshipStatus,
  //   required List<String> interests,
  //   required List<String> language,
  //   required String nationality,
  //   required String location,
  //   String? profession,
  //   String? bio,
  //   String? image,
  // }) async {
  //   try {
  //     FormData formDataMap = FormData.fromMap({
  //       "name": name,
  //       "gender": gender,
  //       "birthday": birthday,
  //       "relationshipStatus": relationshipStatus,
  //       "bio": bio,
  //       "profession": profession,
  //       // "interests": interests,
  //       "language": language,
  //       "nationality": nationality,
  //       "location": location,
  //     });

  //     for (var element in interests) {
  //       formDataMap.fields.add(MapEntry("interests[]", element));
  //     }
  //     // Image থাকলে এবং file path valid হলে MultipartFile যোগ করি
  //     if (image != null && image.isNotEmpty) {
  //       try {
  //         // Verify file exists
  //         final file = File(image);
  //         if (await file.exists()) {
  //           String fileName = file.path.split('/').last;
  //           var mimeType = lookupMimeType(file.path);

  //           formDataMap.files.add(
  //             MapEntry(
  //               "image",
  //               await MultipartFile.fromFile(
  //                 file.path,
  //                 filename: fileName,
  //                 contentType: MediaType.parse(
  //                   mimeType ?? 'application/octet-stream',
  //                 ),
  //               ),
  //             ),
  //           );
  //         } else {
  //           AppPrint.appLog("Image file does not exist at path: $image");
  //         }
  //       } catch (e) {
  //         AppPrint.appError("Error processing image file: $e");
  //       }
  //     }

  //     var response = await apiServices.apiPatchServices(
  //       url: AppApiEndPoint.instance.profile,
  //       body: formDataMap,
  //     );

  //     if (response != null) {
  //       AppPrint.appLog("✅ Profile updated successfully");
  //       return true;
  //     } else {
  //       AppPrint.appLog("❌ Profile update failed: Response is null");
  //       return false;
  //     }
  //   } catch (e) {
  //     AppPrint.appError(e, title: "updateUserProfile");
  //     return false;
  //   }
  // }

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
