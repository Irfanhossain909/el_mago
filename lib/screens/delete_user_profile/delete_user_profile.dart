import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/screens/delete_user_profile/controller/delete_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_card/app_card.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_loading/app_loading.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteUserProfile extends StatelessWidget {
  const DeleteUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final String email = Get.arguments ?? '';
    return GetBuilder<DeleteController>(
      init: DeleteController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(title: 'Delete Account'),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: AppCard(
              height: AppSize.size.height * 0.25,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.snackbar(
                        "Action Not Allowed",
                        "You cannot edit your email address.",
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: AppText(
                        data: email,
                        fontSize: AppSize.width(value: 16),
                        fontWeight: FontWeight.w500,
                        color: AppColor.black.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                  AppInputWidgetTwo(
                    controller: controller.password,
                    isPassWord: true,
                    hintText: 'Password',
                  ),
                  SizedBox(height: 16),
                  AppButton(
                    onTap: () {
                      Get.dialog(
                        AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 24,
                          ),
                          content: Obx(() {
                            // Show loading indicator if delete operation is in progress
                            if (controller.isLoading.value) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppLoading(),
                                  SizedBox(height: AppSize.height(value: 16)),
                                  AppText(
                                    data: 'Deleting account...',
                                    fontSize: AppSize.width(value: 16),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              );
                            }

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // 🔴 Delete Icon
                                Icon(
                                  Icons.delete_forever_rounded,
                                  color: Colors.red,
                                  size: AppSize.width(value: 50),
                                ),
                                SizedBox(height: AppSize.height(value: 16)),

                                // 🧾 Header
                                AppText(
                                  data: 'Delete Account',
                                  fontSize: AppSize.width(value: 18),
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(height: AppSize.height(value: 10)),

                                // 📄 Subtitle
                                AppText(
                                  data:
                                      'Are you sure you want to delete your account?',
                                  fontSize: AppSize.width(value: 16),
                                  fontWeight: FontWeight.w400,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: AppSize.height(value: 24)),

                                // 🔘 Buttons
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Cancel Button
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey.shade300,
                                          foregroundColor: Colors.black87,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        onPressed: () => Get.back(),
                                        child: const Text('Cancel'),
                                      ),
                                    ),
                                    SizedBox(width: AppSize.width(value: 12)),
                                    // Delete Button
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Get.back(); // Close dialog first
                                          controller.deleteUser();
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                        ),
                      );
                    },
                    title: "Confirm Delete",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
