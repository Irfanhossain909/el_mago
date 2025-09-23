import 'package:el_mago/const/role.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/services/repository/auth_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  AuthRepository authRepository = AuthRepository.instance;
  // Rxn allows the value to be null or a valid Role.
  final Rxn<Role> userRole = Rxn<Role>();

  //TextEditingControllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  //validate function
  bool validate() {
    if (emailController.text.isEmpty) {
      Get.snackbar("Error", "Please enter your email");
      return false; // Return false if email is empty
    } else if (passwordController.text.isEmpty) {
      Get.snackbar("Error", "Please enter your password");
      return false; // Return false if password is empty
    } else if (addressController.text.isEmpty) {
      Get.snackbar("Error", "Please enter your address");
      return false; // Return false if address is empty
    } else if (confirmpasswordController.text.isEmpty) {
      Get.snackbar("Error", "Please confirm your password");
      return false; // Return false if confirm password is empty
    } else if (passwordController.text != confirmpasswordController.text) {
      Get.snackbar("Error", "Passwords do not match");
      return false; // Return false if passwords don't match
    } else if (fullNameController.text.isEmpty) {
      Get.snackbar("Error", "Please enter your full name");
      return false; // Return false if full name is empty
    } else if (userRole.value == null) {
      Get.snackbar("Error", "Please select your role");
      return false; // Return false if role is not selected
    }

    return true; // Return true if all validations pass
  }

  //Loading state
  RxBool isLoading = false.obs;

  // Signup function
  Future<void> signUp() async {
    try {
      // Validate user input
      bool isValid = validate(); // Call the validate function to check inputs

      // If validation fails, exit early
      if (!isValid) return;

      // Show loading state
      isLoading.value = true;

      // Make the sign-up request to the repository
      var response = await authRepository.signUp(
        name: fullNameController.text,
        email: emailController.text,
        address: addressController.text,
        password: passwordController.text,
        role: userRole.value!.name,
      );

      if (response) {
        Get.toNamed(
          AppRoutes.instance.otpVerifyScreen,
          arguments: emailController.text,
        );
      } else {
        isLoading.value = false;
        Get.snackbar("Error", "Sign-up failed. Please try again.");
      }
    } catch (e) {
      // Handle any errors that occur during the sign-up process
      AppPrint.appError(e, title: "SignUpController");
      Get.snackbar("Error", "An error occurred during sign-up.");
    } finally {
      // Hide loading state
      isLoading.value = false;
    }
  }

  // Setter function to set the value of workedInChildCare
  void setUserRole(Role? value) {
    userRole.value = value;
    AppPrint.apiResponse(userRole.value?.name, title: "Updated Role");
  }

  //inisialize Contreoller
  void appInisializ() {
    emailController = TextEditingController();
    addressController = TextEditingController();
    passwordController = TextEditingController();
    confirmpasswordController = TextEditingController();
    fullNameController = TextEditingController();
  }

  //controller Dispose
  void appDispose() {
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    fullNameController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    appInisializ();
  }

  @override
  void onClose() {
    appDispose();
    super.onClose();
  }
}
