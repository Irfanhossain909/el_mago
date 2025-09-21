import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinnierenee12/const/app_color.dart';
import 'package:tinnierenee12/const/assets_icons_path.dart';
import 'package:tinnierenee12/routes/app_routes.dart';
import 'package:tinnierenee12/screen/role_selection_screen/role_selection_screen.dart';
import 'package:tinnierenee12/utils/app_size.dart';
import 'package:tinnierenee12/widget/app_button/app_button.dart';
import 'package:tinnierenee12/widget/app_card/app_card.dart';
import 'package:tinnierenee12/widget/app_image/app_image.dart';
import 'package:tinnierenee12/widget/app_image/app_image_circular.dart';
import 'package:tinnierenee12/widget/app_log/gap.dart';
import 'package:tinnierenee12/widget/app_text/app_text.dart';
import 'package:tinnierenee12/widget/appbar/custom_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Profile",
        autoShowLeading: false,
        action: [
          if (roll == "employee")
            IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.instance.employeeSettingScreen);
              },
              icon: Icon(Icons.settings, color: AppColor.black),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppSize.width(value: 16)),
              child: Row(
                children: [
                  AppImageCircular(
                    fit: BoxFit.cover,
                    url:
                        "https://cdn.pixabay.com/photo/2016/12/07/21/01/cartoon-1890438_640.jpg",
                    width: AppSize.width(value: 124),
                    height: AppSize.width(value: 124),
                  ),
                  Gap(width: AppSize.width(value: 20)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppSize.size.height * 0.014,
                    children: [
                      AppText(
                        data: "Sabbir Ahmed",
                        fontSize: AppSize.width(value: 18),
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                      ),
                      AppText(
                        data: "012345-678912",
                        fontSize: AppSize.width(value: 14),
                        fontWeight: FontWeight.w500,
                        // Use the text color from the current theme
                        color: AppColor.white,
                      ),

                      AppButton(
                        onTap: () {
                          Get.toNamed(AppRoutes.instance.changeProfileScreen);
                        },
                        title: "Edit Profile",

                        width: AppSize.size.width * 0.3,
                        height: AppSize.size.width * 0.1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (roll == "client")
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
                        Get.toNamed(AppRoutes.instance.changePassScreen);
                      },
                      text: "Password",
                    ),
                    ProfileRow(
                      iconPath: AssetsPath.transaction,
                      onTap: () {
                        // Get.toNamed(AppRoutes.instance.changePassScreen);
                      },
                      text: "Transaction History",
                    ),
                    ProfileRow(
                      iconPath: AssetsPath.contactUs,
                      onTap: () {
                        Get.toNamed(AppRoutes.instance.contactUsScreen);
                      },
                      text: "Contact Us",
                    ),
                    ProfileRow(
                      iconPath: AssetsPath.terms,
                      onTap: () {
                        Get.toNamed(AppRoutes.instance.termsCondiScreen);
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

                    // ProfileRow(
                    //   appThemeColor: appThemeColor,
                    //   iconPath: AssetsPath.isDelete,
                    //   onTap: () {
                    //     showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         return AlertDialog(
                    //           title: Padding(
                    //             padding: const EdgeInsets.all(12),
                    //             child: Column(
                    //               spacing: AppSize.size.height * 0.013,
                    //               children: [
                    //                 Icon(
                    //                   Icons.delete,
                    //                   size: AppSize.width(value: 66),
                    //                   color: AppColor.button5Dark,
                    //                 ),
                    //                 AppText(
                    //                   data: "Want to delete account !",
                    //                   fontSize: AppSize.width(value: 18),
                    //                   fontWeight: FontWeight.w700,
                    //                   color: Colors.black,
                    //                 ),
                    //                 AppText(
                    //                   data:
                    //                       "Please confirm your password to remove your account.",
                    //                   fontSize: AppSize.width(value: 16),
                    //                   fontWeight: FontWeight.w500,
                    //                   textAlign: TextAlign.center,
                    //                   color: Colors.black,
                    //                 ),
                    //                 AppInputWidgetTwo(
                    //                   title: "Password",
                    //                   hintText: "Password",
                    //                 ),
                    //                 Gap(height: 4),
                    //                 Row(
                    //                   children: [
                    //                     Expanded(
                    //                       child: InkWell(
                    //                         onTap: () {
                    //                           Navigator.of(context).pop();
                    //                         },
                    //                         child: Container(
                    //                           padding: EdgeInsets.symmetric(
                    //                             horizontal: AppSize.width(
                    //                               value: 18,
                    //                             ),
                    //                             vertical: AppSize.width(value: 8),
                    //                           ),
                    //                           decoration: BoxDecoration(
                    //                             borderRadius:
                    //                                 BorderRadius.circular(8),
                    //                             border: Border.all(
                    //                               color: AppColor.button5Dark,
                    //                             ),
                    //                           ),
                    //                           child: Center(
                    //                             child: AppText(
                    //                               data: "Cancel",
                    //                               fontSize: AppSize.width(
                    //                                 value: 16,
                    //                               ),
                    //                               fontWeight: FontWeight.w500,
                    //                               color: Colors.black,
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     Gap(width: 20),
                    //                     Expanded(
                    //                       child: AppButton(
                    //                         onTap: () {
                    //                           Navigator.of(context).pop();
                    //                         },
                    //                         height: 36,
                    //                         title: "Delete",
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     );
                    //   },
                    //   text: "Delete Account",
                    // ),
                    ProfileRow(
                      iconPath: AssetsPath.logout,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return LogOutpopUp();
                          },
                        );
                      },
                      text: "Log Out",
                    ),
                  ],
                ),
              ),

            if (roll == "employee")
              AppCard(
                child: Column(
                  spacing: AppSize.size.height * 0.03,
                  children: [
                    ProfileRow(
                      iconPath: AssetsPath.editBio,
                      onTap: () {},
                      text: "Edit Bio",
                    ),
                    ProfileRow(
                      iconPath: AssetsPath.editQualification,
                      onTap: () {},
                      text: "Edit Qualification",
                    ),
                    ProfileRow(
                      iconPath: AssetsPath.employeeMedicale,
                      onTap: () {},
                      text: "Employee Medical Statement",
                    ),
                    ProfileRow(
                      iconPath: AssetsPath.qualificationDocument,
                      onTap: () {},
                      text: "Qualification Documents",
                    ),
                    ProfileRow(
                      iconPath: AssetsPath.logout,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return LogOutpopUp();
                          },
                        );
                      },
                      text: "Log Out",
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class LogOutpopUp extends StatelessWidget {
  const LogOutpopUp({super.key});

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
                  onTap: () {
                    // Get.offAllNamed(AppRoutes.instance.authScreen);
                  },
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
            path: iconPath ?? AssetsPath.arrowBack,
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
