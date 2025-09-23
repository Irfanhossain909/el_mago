import 'package:el_mago/const/app_storage_key.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/widgets/app_log/error_log.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageServices {
  GetStorageServices._privateConstructor();
  static final GetStorageServices _instance =
      GetStorageServices._privateConstructor();
  static GetStorageServices get instance => _instance;

  ////////////// storage initial
  GetStorage box = GetStorage();

  ////////////////  token
  Future<void> setToken(String value) async {
    try {
      await box.write(AppStorageKey.instance.token, value);
      await box.save();
    } catch (e) {
      errorLog("set token ", e);
    }
  }

  String getToken() {
    try {
      return box.read(AppStorageKey.instance.token) ?? "";
    } catch (e) {
      errorLog("get token", e);
      return "";
    }
  }

  // ////////////////  reset token
  // Future<void> setResetToken(String value) async {
  //   try {
  //     await box.write(AppStorageKey.instance.resetToken, value);
  //     await box.save();
  //   } catch (e) {
  //     errorLog("set reset token ", e);
  //   }
  // }

  // String getResetToken() {
  //   try {
  //     return box.read(AppStorageKey.instance.resetToken) ?? "";
  //   } catch (e) {
  //     errorLog("get reset token", e);
  //     return "";
  //   }
  // }

  // Future<void> setfullFil(bool value) async {
  //   try {
  //     await box.write(AppStorageKey.instance.setFullFill, value);
  //     await box.save();
  //   } catch (e) {
  //     errorLog("set Full Fill", e);
  //   }
  // }

  // bool getfullFil() {
  //   try {
  //     return box.read(AppStorageKey.instance.setFullFill) ?? false;
  //   } catch (e) {
  //     errorLog("get FullFill", e);
  //     return false;
  //   }
  // }

  //////////////// UID (_id)
  Future<void> setUID(String value) async {
    try {
      await box.write("UID", value);
      await box.save();
    } catch (e) {
      errorLog("set UID", e);
    }
  }

  String getUID() {
    try {
      return box.read("UID") ?? "";
    } catch (e) {
      errorLog("get UID", e);
      return "";
    }
  }

  ///////////////////////  user role
  Future<void> setUserRole(String value) async {
    try {
      await box.write("role", value);
    } catch (e) {
      errorLog("set user role", e);
    }
  }

  String getUserRole() {
    try {
      return box.read("role") ?? "USER";
    } catch (e) {
      errorLog("get user role", e);
      return "USER";
    }
  }

  ////////////  get language
  String? getLanguage() {
    return box.read(AppStorageKey.instance.language);
  }

  ////////////  set language
  Future<void> setLanguage(String value) async {
    await box.write(AppStorageKey.instance.language, value);
  }

  ////////////  get country
  String getCountry() {
    return box.read(AppStorageKey.instance.country) ?? "";
  }

  ////////////  set country
  Future<void> setCountry(String value) async {
    await box.write(AppStorageKey.instance.country, value);
  }

  ///logout - Clears all locally stored data and navigates to sign in screen
  Future<void> storageClear() async {
    try {
      // Clear all stored data
      await box.remove(AppStorageKey.instance.token); // Remove token
      await box.remove(
        AppStorageKey.instance.refreshToken,
      ); // Remove refresh token
      await box.remove("UID"); // Remove user ID
      await box.remove("role"); // Remove user role
      // await box.remove(
      //   AppStorageKey.instance.setFullFill,
      // ); // Remove profile completion status
      await box.remove(
        AppStorageKey.instance.language,
      ); // Remove language preference
      await box.remove(
        AppStorageKey.instance.country,
      ); // Remove country preference

      // Save changes
      await box.save();

      // Note: Navigation is now handled by the calling controller
    } catch (e) {
      errorLog("storageClear", e);
    }
  }

  /// Complete logout with navigation - use this for full logout
  Future<void> completeLogout() async {
    try {
      await storageClear();
      // Navigate to sign in screen and remove all previous routes
      Get.offAllNamed(AppRoutes.instance.signinScreen);
    } catch (e) {
      errorLog("completeLogout", e);
    }
  }

  // Add refresh token storage and handling
  Future<void> setRefreshToken(String token) async {
    await box.write(AppStorageKey.instance.refreshToken, token);
  }

  String getRefreshToken() {
    try {
      return box.read(AppStorageKey.instance.refreshToken) ?? "";
    } catch (e) {
      errorLog("get refresh token", e);
      return "";
    }
  }

  //   Future<void> storageClear() async {
  //   try {
  //     // Clear all stored data
  //     await box.remove(AppStorageKey.instance.token);
  //     await box.remove(AppStorageKey.instance.refreshToken);
  //     await box.remove("role"); // Clear user role
  //     await box.remove(AppStorageKey.instance.userData);
  //     await box.remove(AppStorageKey.instance.suggestion);
  //     await box.remove(AppStorageKey.instance.country);

  //     // Navigate to sign in screen and remove all previous routes
  //     Get.offAllNamed(AppRoutes.signIn);
  //   } catch (e) {
  //     errorLog("logout", e);
  //   }
  // }
}
