import 'dart:io';
import 'package:el_mago/screens/profile_screen/controller/profile_controller.dart';
import 'package:el_mago/services/repository/profile_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ChnageProfileController extends GetxController {
  //text controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  //all repositories
  final ProfileRepository profileRepository = Get.find<ProfileRepository>();
  //loading state
  RxBool isLoading = false.obs;
  //profile update function
  Future<void> updateProfile() async {
    try {
      isLoading.value = true;
      var response = await profileRepository.updateUserProfile(
        name: nameController.text,
        address: addressController.text,
        phone: phoneController.text,
        image: cameraImage.value,
      );
      if (response) {
        Get.snackbar("Success", "Profile updated successfully");

        await profileController.fetchProfileData();
        Get.close(1);
      } else {
        Get.snackbar("Error", "Profile update failed");
        isLoading.value = false;
      }
    } catch (e) {
      AppPrint.appError(e, title: "updateProfile");
    } finally {
      isLoading.value = false;
    }
  }

  ///////////////////////image////////////////////////////////////////

  RxString cameraImage = ''.obs;

  void removeImage() {
    cameraImage.value = "";
  }

  Future<void> getImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    // Request permission for camera
    PermissionStatus cameraPermission = await Permission.camera.request();

    // Check if permission is granted
    if (cameraPermission.isGranted) {
      // Show a dialog to choose between camera or gallery
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Choose Option".tr),
          content: Text("Select where you want to pick the image from:".tr),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                // Open the camera if the user selects camera
                final XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 5,
                );
                AppPrint.appLog(image);
                if (image != null) {
                  File file = File(image.path);
                  AppPrint.appLog(file);
                  AppPrint.appLog(file.runtimeType);
                  // Add image path to cameraImages list
                  cameraImage.value = file.path;
                }
              },
              child: AppText(
                data: "Camera",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                // Open the gallery if the user selects gallery (single image)
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 5,
                );
                if (image != null) {
                  File file = File(image.path);
                  AppPrint.appLog(file);
                  AppPrint.appLog(file.runtimeType);

                  // Add image path to galleryImages list
                  cameraImage.value = image.path;
                }
              },
              child: AppText(
                data: "Gallery",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    } else {
      // If permission is denied, show a dialog and guide user to app settings
      if (cameraPermission.isDenied || cameraPermission.isPermanentlyDenied) {
        // Show a dialog explaining the need for the permission obo
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Permission Denied".tr),
            content: Text(
              "Camera permission is required to take a photo. Please enable it from the app settings."
                  .tr,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Open app settings
                  openAppSettings();
                },
                child: Text('Open Settings'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'.tr),
              ),
            ],
          ),
        );
      }
    }
  }

  //////////////////////////////////////////////////////////////////////

  ///controller initialization value
  void appInit() {
    // Set text values for controllers with existing profile data
    nameController.text = profileController.profileData.value?.name ?? '';
    phoneController.text = profileController.profileData.value?.phone ?? '';
    addressController.text = profileController.profileData.value?.address ?? '';
    cameraImage.value = profileController.profileData.value?.image ?? '';

    AppPrint.appLog(profileController.profileData.value?.image);
    AppPrint.appLog(profileController.profileData.value?.phone);
    AppPrint.appLog(profileController.profileData.value?.address);
    AppPrint.appLog(profileController.profileData.value?.email);
  }

  ProfileController profileController = Get.put(ProfileController());

  @override
  void onInit() {
    appInit();

    super.onInit();
  }
}
