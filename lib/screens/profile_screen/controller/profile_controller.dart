import 'package:el_mago/models/user_model/user_model.dart';
import 'package:el_mago/services/repository/profile_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  //all repository

  ProfileRepository profileRepository = ProfileRepository.instance;

  ///Model variables
  Rxn<UserModelData> profileData = Rxn<UserModelData>();

  //Loading state
  RxBool loading = false.obs;

  //get profile
  Future<void> fetchProfileData() async {
    try {
      var response = await profileRepository.getProfileData();
      if (response != null) {
        profileData.value = response;
        AppPrint.apiResponse(response);
      }
      AppPrint.apiResponse(profileData.value?.image);
    } catch (e) {
      AppPrint.appError(e, title: "fetchProfileData");
    }
  }

  @override
  void onInit() {
    fetchProfileData();
    super.onInit();
  }
}
