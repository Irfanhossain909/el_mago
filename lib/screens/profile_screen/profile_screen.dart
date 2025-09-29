import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/const/role.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/screens/profile_screen/controller/profile_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_image/app_image_circular.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  // final ProfileController controller = Get.put(ProfileController());
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(autoShowLeading: false, title: "Profile"),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() {
                  return Padding(
                    padding: EdgeInsets.all(AppSize.width(value: 16)),
                    child: Row(
                      children: [
                        AppImageCircular(
                          fit: BoxFit.cover,
                          url:
                              "${AppApiEndPoint.domain}${controller.profileData.value?.image}",
                          width: AppSize.width(value: 124),
                          height: AppSize.width(value: 124),
                        ),
                        Gap(width: AppSize.width(value: 20)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            AppText(
                              maxLines: 1,
                              data:
                                  controller.profileData.value?.name ??
                                  "Unknown",
                              fontSize: AppSize.width(value: 16),
                              fontWeight: FontWeight.w700,
                              color: AppColor.black,
                            ),
                            Gap(height: AppSize.width(value: 8)),
                            if (controller.profileData.value?.phone != null)
                              AppText(
                                data:
                                    controller.profileData.value?.phone ??
                                    "No Phone",
                                fontSize: AppSize.width(value: 12),
                                fontWeight: FontWeight.w400,
                                // Use the text color from the current theme
                                color: AppColor.black,
                              ),
                            Gap(height: 4),
                            AppText(
                              data:
                                  controller.profileData.value?.address ??
                                  "Dhaka, Bangladesh",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w400,
                              // Use the text color from the current theme
                              color: AppColor.black,
                            ),
                            Gap(height: AppSize.width(value: 12)),
                            AppButton(
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.instance.changeProfileScreen,
                                );
                              },
                              title: "Edit Profile",

                              width: AppSize.size.width * 0.3,
                              height: AppSize.size.width * 0.1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),

                Container(
                  decoration: BoxDecoration(
                    color: AppColor.white, // Background color of the container
                    borderRadius: BorderRadius.circular(
                      AppSize.width(value: 8),
                    ), // Border radius
                  ),
                  padding: EdgeInsets.all(24),
                  child: Column(
                    spacing: AppSize.size.height * 0.04,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileRow(
                        iconPath: AssetsPath.pass,
                        onTap: () {
                          Get.toNamed(AppRoutes.instance.changePasswordScreen);
                        },
                        text: "Password",
                      ),
                      // Add the My Sales section for SALES role users
                      if (controller.profileData.value?.role == Role.SALES.name)
                        ProfileRow(
                          iconPath: AssetsPath.mySales,
                          onTap: () {
                            Get.toNamed(AppRoutes.instance.sealesMySalesScreen);
                          },
                          text: "My Sales",
                        ),
                      if (controller.profileData.value?.role == Role.SALES.name)
                        ProfileRow(
                          iconPath: AssetsPath.myTerritory,
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.instance.salesMyTerritoryScreen,
                            );
                          },
                          text: "My Territory",
                        ),
                      ProfileRow(
                        iconPath: AssetsPath.terms,
                        onTap: () {
                          Get.toNamed(AppRoutes.instance.termScreen);
                        },
                        text: "Terms & Conditions",
                      ),
                      ProfileRow(
                        iconPath: AssetsPath.privicy,
                        onTap: () {
                          Get.toNamed(AppRoutes.instance.privicyScreen);
                        },
                        text: "Privacy Policy",
                      ),

                      ProfileRow(
                        iconPath: AssetsPath.logout,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return LogOutpopUp(
                                onTap: () {
                                  controller.logout();
                                },
                              );
                            },
                          );
                        },
                        text: "Log Out",
                      ),
                    ],
                  ),
                ),

                // if (roll == "employee")
                //   AppCard(
                //     child: Column(
                //       spacing: AppSize.size.height * 0.03,
                //       children: [
                //         ProfileRow(
                //           iconPath: AssetsPath.editBio,
                //           onTap: () {},
                //           text: "Edit Bio",
                //         ),
                //         ProfileRow(
                //           iconPath: AssetsPath.editQualification,
                //           onTap: () {},
                //           text: "Edit Qualification",
                //         ),
                //         ProfileRow(
                //           iconPath: AssetsPath.employeeMedicale,
                //           onTap: () {},
                //           text: "Employee Medical Statement",
                //         ),
                //         ProfileRow(
                //           iconPath: AssetsPath.qualificationDocument,
                //           onTap: () {},
                //           text: "Qualification Documents",
                //         ),
                //         ProfileRow(
                //           iconPath: AssetsPath.logout,
                //           onTap: () {
                //             showDialog(
                //               context: context,
                //               builder: (BuildContext context) {
                //                 return LogOutpopUp();
                //               },
                //             );
                //           },
                //           text: "Log Out",
                //         ),
                //       ],
                //     ),
                //   ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LogOutpopUp extends StatelessWidget {
  final Function? onTap;
  const LogOutpopUp({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        spacing: AppSize.size.height * 0.03,
        children: [
          AppImage(
            path: AssetsPath.logout,
            width: AppSize.width(value: 88),
            iconColor: AppColor.black,
          ),
          AppText(
            data: "Do you want to log out of your profile?",
            fontSize: AppSize.width(value: 16),
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSize.width(value: 18),
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColor.black),
                    ),
                    child: Center(
                      child: AppText(
                        data: "Cancel",
                        fontSize: AppSize.width(value: 16),
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Gap(width: 20),
              Expanded(
                child: AppButton(
                  onTap: onTap as void Function(),
                  height: 36,
                  title: "Logout",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileRow extends StatelessWidget {
  final String? iconPath;
  final String? text;
  final VoidCallback? onTap;
  const ProfileRow({super.key, this.iconPath, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        spacing: AppSize.width(value: 20),
        children: [
          AppImage(
            path: iconPath ?? AssetsPath.arrowRight,
            iconColor: AppColor.black,
            width: AppSize.width(value: 24),
            height: AppSize.width(value: 24),
          ),
          AppText(
            data: text ?? "",
            fontWeight: FontWeight.w500,
            color: AppColor.black,
            fontSize: AppSize.width(value: 14),
          ),
          Spacer(),
          AppImage(
            iconColor: AppColor.black,
            path: AssetsPath.arrowRight,
            width: AppSize.width(value: 24),
            height: AppSize.width(value: 24),
          ),
        ],
      ),
    );
  }
}
