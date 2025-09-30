import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:el_mago/screens/retailer_my_subscription_screen/controller/retailer_my_subscription_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RetailerMySubscriptionScreen extends StatelessWidget {
  const RetailerMySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RetailerMySubscriptionController>(
      init: RetailerMySubscriptionController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(
            autoShowLeading: false,
            title: 'My Subscription',
          ),
          body: Padding(
            padding: EdgeInsets.all(AppSize.width(value: 16)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    spacing: AppSize.width(value: 24),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: controller.status.value
                                ? Colors.blue
                                : Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: controller.status.value
                              ? Colors.blue.withValues(alpha: 0.3)
                              : Colors.red.withValues(alpha: 0.3),
                        ),
                        padding: EdgeInsets.all(AppSize.width(value: 12)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              color: controller.status.value
                                  ? Colors.blue
                                  : Colors.red,
                              size: 16,
                            ),
                            Gap(width: AppSize.width(value: 8)),
                            AppText(
                              data: controller.message.value,
                              fontSize: AppSize.width(value: 12),
                              color: controller.status.value
                                  ? Colors.blue
                                  : Colors.red,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: controller.status.value
                            ? AppButton(
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes
                                        .instance
                                        .retailerSelectExtraBoxScreen,
                                  );
                                },
                                height: AppSize.width(value: 38),
                                width: AppSize.size.width * 0.4,
                                title: "Edit Selected Boxes",
                              )
                            : AppButton(
                                height: AppSize.width(value: 38),
                                width: AppSize.size.width * 0.4,
                                filColor: Colors.grey.withValues(alpha: .7),
                                title: "Selected Boxes",
                              ),
                      ),
                    ],
                  ),

                  SizedBox(
                      height: AppSize.size.height * 0.7,
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          top: AppSize.size.height * 0.002,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.subModelData.length,
                        itemBuilder: (context, index) {
                          final subModel = controller.subModelData[index];

                          return SizedBox(
                            width: AppSize.size.width * 0.9,
                            child: SubcriptionCard(
                              isActive:
                                  controller
                                          .retailerSelectExtraboxController
                                          .currentSubscription
                                          .value
                                          ?.id ==
                                      subModel.id
                                  ? true
                                  : false,
                              title: subModel.subscription,
                              title2: subModel.freeShipping,
                              title3: subModel.noCreditCardFee,
                              title4: subModel.exclusiveProducts,
                              title5: subModel.limitedReleases,
                              onTap: (isChecked, arg2) {
                                Get.toNamed(
                                  AppRoutes
                                      .instance
                                      .retailerComplateSubscriptionScreen,
                                  arguments: {"arg1": subModel, "arg2": arg2},
                                );
                              },
                            ),
                          );
                        },
                      ),
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

class SubcriptionCard extends StatefulWidget {
  final String? title;
  final String? title2;
  final String? title3;
  final String? title4;
  final String? title5;

  /// এখানে bool peram পাঠানোর জন্য change করা হয়েছে
  final void Function(bool isChecked, String? arg2)? onTap;

  final bool isActive;

  const SubcriptionCard({
    super.key,
    this.title,
    this.title2,
    this.title3,
    this.title4,
    this.title5,
    this.onTap,
    this.isActive = false,
  });

  @override
  State<SubcriptionCard> createState() => _SubcriptionCardState();
}

class _SubcriptionCardState extends State<SubcriptionCard> {
  bool isChecked = false;
  int boxCount = 0; // Default value for boxes
  final TextEditingController _boxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _boxController.text = boxCount.toString();
  }

  @override
  void dispose() {
    _boxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(AppSize.width(value: 16)),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .1),
                        offset: const Offset(0, 2),
                        blurRadius: 8,
                      ),
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .1),
                        offset: const Offset(0, -2),
                        blurRadius: 8,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(
                      AppSize.width(value: 12),
                    ),
                    color: AppColor.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppSize.size.height * 0.04,
                          horizontal: AppSize.size.width * 0.1,
                        ),
                        child: Column(
                          spacing: AppSize.size.height * 0.015,
                          children: [
                            AppImage(
                              width: AppSize.width(value: 40),
                              height: AppSize.width(value: 40),
                              path: AssetsPath.subscriptionIcon,
                            ),
                            AppText(
                              data: widget.title ?? "no text",
                              fontSize: AppSize.width(value: 28),
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                            Gap(height: AppSize.size.height * 0.02),
                            Row(
                              spacing: AppSize.width(value: 12),
                              children: [
                                Icon(
                                  Icons.done_rounded,
                                  color: AppColor.blue,
                                  size: AppSize.width(value: 16),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      AppText(
                                        data:
                                            "Platinum Tier : $boxCount boxes per month",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                      Gap(width: 4),
                                      InkWell(
                                        onTap: () {
                                          _boxController.text = boxCount
                                              .toString();
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      String inputValue =
                                                          _boxController.text
                                                              .trim();
                                                      if (inputValue
                                                          .isNotEmpty) {
                                                        int? newBoxCount =
                                                            int.tryParse(
                                                              inputValue,
                                                            );
                                                        if (newBoxCount !=
                                                                null &&
                                                            newBoxCount > 0) {
                                                          setState(() {
                                                            boxCount =
                                                                newBoxCount;
                                                          });
                                                          Navigator.of(
                                                            context,
                                                          ).pop();
                                                          Get.snackbar(
                                                            "Updated",
                                                            "Box count updated to $boxCount",
                                                          );
                                                        } else {
                                                          Get.snackbar(
                                                            "Invalid Input",
                                                            "Please enter a valid number greater than 0",
                                                          );
                                                        }
                                                      } else {
                                                        Get.snackbar(
                                                          "Empty Field",
                                                          "Please enter a box number",
                                                        );
                                                      }
                                                    },
                                                    child: AppText(
                                                      data: "Save",
                                                      fontSize: AppSize.width(
                                                        value: 16,
                                                      ),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColor.blue,
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                    },
                                                    child: AppText(
                                                      data: "Cancel",
                                                      fontSize: AppSize.width(
                                                        value: 16,
                                                      ),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                                title: AppInputWidgetTwo(
                                                  controller: _boxController,
                                                  isOptional: true,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  title: "Edit Box",
                                                  hintText: "Enter box number",
                                                ),
                                                backgroundColor: AppColor.white,
                                              );
                                            },
                                          );
                                        },
                                        child: AppImage(
                                          width: AppSize.width(value: 16),
                                          path: AssetsPath.editText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SubWidGetRow(text: widget.title2 ?? "no text"),
                            SubWidGetRow(text: widget.title3 ?? "no text"),
                            SubWidGetRow(text: widget.title4 ?? "no text"),
                            SubWidGetRow(text: widget.title5 ?? "no text"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSize.width(value: 16),
                          vertical: AppSize.width(value: 16),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: AppSize.width(value: 24),
                              width: AppSize.width(value: 24),
                              child: Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value ?? false;
                                  });
                                },
                                activeColor: AppColor.blue,
                                checkColor: Colors.white,
                                side: BorderSide(
                                  color: AppColor.black,
                                  width: 2,
                                ),
                              ),
                            ),
                            Gap(width: AppSize.width(value: 12)),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate to terms and conditions screen
                                },
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: AppSize.width(value: 14),
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      const TextSpan(text: "I Agree to the "),
                                      TextSpan(
                                        text: "terms & conditions",
                                        style: TextStyle(
                                          color: AppColor.blue,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSize.width(value: 28),
                          vertical: AppSize.width(value: 24),
                        ),
                        child: AppButton(
                          borderRadius: BorderRadius.circular(12),
                          title: "Choose Plan",
                          filColor: isChecked
                              ? AppColor.blue
                              : AppColor.blue.withValues(alpha: 0.3),
                          onTap: () {
                            if (isChecked) {
                              // ✅ এখানে parameter pass হচ্ছে
                              widget.onTap?.call(
                                isChecked,
                                boxCount.toString(),
                              );

                              Get.toNamed(
                                AppRoutes
                                    .instance
                                    .retailerComplateSubscriptionScreen,
                              );
                            } else {
                              Get.snackbar(
                                "Terms Required",
                                "Please agree to terms & conditions first",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          widget.isActive
              ? Positioned(
                  top: 10,
                  right: 0,
                  child: AppImage(
                    width: AppSize.width(value: 88),
                    path: AssetsPath.activeCard,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

// class SubcriptionCard extends StatefulWidget {
//   final String? title;
//   final String? title2;
//   final String? title3;
//   final String? title4;
//   final String? title5;
//   final Function? onTap;
//   final bool isActive;
//   const SubcriptionCard({
//     super.key,
//     this.title,
//     this.title2,
//     this.title3,
//     this.title4,
//     this.title5,
//     this.onTap,
//     this.isActive = false,
//   });

//   @override
//   State<SubcriptionCard> createState() => _SubcriptionCardState();
// }

// class _SubcriptionCardState extends State<SubcriptionCard> {
//   bool isChecked = false;
//   String? selectedBoxValue;
//   int boxCount = 0; // Default value for boxes
//   final TextEditingController _boxController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _boxController.text = boxCount.toString();
//   }

//   @override
//   void dispose() {
//     _boxController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(AppSize.width(value: 16)),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withValues(alpha: .1),
//                         offset: Offset(0, 2),
//                         blurRadius: 8,
//                       ),
//                       BoxShadow(
//                         color: Colors.black.withValues(alpha: .1),
//                         offset: Offset(0, -2),
//                         blurRadius: 8,
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(
//                       AppSize.width(value: 12),
//                     ),
//                     color: AppColor.white,
//                   ),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           vertical: AppSize.size.height * 0.04,
//                           horizontal: AppSize.size.width * 0.1,
//                         ),
//                         child: Column(
//                           spacing: AppSize.size.height * 0.015,
//                           children: [
//                             AppImage(
//                               width: AppSize.width(value: 40),
//                               height: AppSize.width(value: 40),
//                               path: AssetsPath.subscriptionIcon,
//                             ),
//                             AppText(
//                               data: widget.title ?? "no text",
//                               fontSize: AppSize.width(value: 28),
//                               fontWeight: FontWeight.w700,
//                               color: Colors.black,
//                             ),
//                             Gap(height: AppSize.size.height * 0.02),
//                             Row(
//                               spacing: AppSize.width(value: 12),
//                               children: [
//                                 Icon(
//                                   Icons.done_rounded,
//                                   color: AppColor.blue,
//                                   size: AppSize.width(value: 16),
//                                 ),
//                                 Expanded(
//                                   child: Row(
//                                     children: [
//                                       AppText(
//                                         data:
//                                             "Platinum Tier : $boxCount boxes per month",
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w400,
//                                         color: Colors.black,
//                                       ),
//                                       Gap(width: 4),
//                                       InkWell(
//                                         onTap: () {
//                                           _boxController.text = boxCount
//                                               .toString();
//                                           showDialog(
//                                             context: context,
//                                             builder: (context) {
//                                               return AlertDialog(
//                                                 actions: [
//                                                   TextButton(
//                                                     onPressed: () {
//                                                       // Validate and save the input
//                                                       String inputValue =
//                                                           _boxController.text
//                                                               .trim();
//                                                       if (inputValue
//                                                           .isNotEmpty) {
//                                                         int? newBoxCount =
//                                                             int.tryParse(
//                                                               inputValue,
//                                                             );
//                                                         if (newBoxCount !=
//                                                                 null &&
//                                                             newBoxCount > 0) {
//                                                           setState(() {
//                                                             boxCount =
//                                                                 newBoxCount;
//                                                           });
//                                                           Navigator.of(
//                                                             context,
//                                                           ).pop();
//                                                           Get.snackbar(
//                                                             "Updated",
//                                                             "Box count updated to $boxCount",
//                                                           );
//                                                         } else {
//                                                           Get.snackbar(
//                                                             "Invalid Input",
//                                                             "Please enter a valid number greater than 0",
//                                                           );
//                                                         }
//                                                       } else {
//                                                         Get.snackbar(
//                                                           "Empty Field",
//                                                           "Please enter a box number",
//                                                         );
//                                                       }
//                                                     },
//                                                     child: AppText(
//                                                       data: "Save",
//                                                       fontSize: AppSize.width(
//                                                         value: 16,
//                                                       ),
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       color: AppColor.blue,
//                                                     ),
//                                                   ),
//                                                   TextButton(
//                                                     onPressed: () {
//                                                       Navigator.of(
//                                                         context,
//                                                       ).pop();
//                                                     },
//                                                     child: AppText(
//                                                       data: "Cancel",
//                                                       fontSize: AppSize.width(
//                                                         value: 16,
//                                                       ),
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       color: Colors.grey,
//                                                     ),
//                                                   ),
//                                                 ],
//                                                 title: AppInputWidgetTwo(
//                                                   controller: _boxController,
//                                                   isOptional: true,
//                                                   keyboardType:
//                                                       TextInputType.number,
//                                                   title: "Edit Box",
//                                                   hintText: "Enter box number",
//                                                 ),
//                                                 backgroundColor: AppColor.white,
//                                               );
//                                             },
//                                           );
//                                         },
//                                         child: AppImage(
//                                           width: AppSize.width(value: 16),
//                                           path: AssetsPath.editText,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SubWidGetRow(text: widget.title2 ?? "no text"),
//                             SubWidGetRow(text: widget.title3 ?? "no text"),
//                             SubWidGetRow(text: widget.title4 ?? "no text"),
//                             SubWidGetRow(text: widget.title5 ?? "no text"),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: AppSize.width(value: 16),
//                           vertical: AppSize.width(value: 16),
//                         ),
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               height: AppSize.width(value: 24),
//                               width: AppSize.width(value: 24),
//                               child: Checkbox(
//                                 value: isChecked,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     isChecked = value ?? false;
//                                   });
//                                 },
//                                 activeColor: AppColor.blue,
//                                 checkColor: Colors.white,
//                                 side: BorderSide(
//                                   color: AppColor.black,
//                                   width: 2,
//                                 ),
//                               ),
//                             ),
//                             Gap(width: AppSize.width(value: 12)),
//                             Expanded(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   // Navigate to terms and conditions screen
//                                 },
//                                 child: RichText(
//                                   text: TextSpan(
//                                     style: TextStyle(
//                                       fontSize: AppSize.width(value: 14),
//                                       color: Colors.black87,
//                                     ),
//                                     children: [
//                                       TextSpan(text: "I Agree to the "),
//                                       TextSpan(
//                                         text: "terms & conditions",
//                                         style: TextStyle(
//                                           color: AppColor.blue,
//                                           decoration: TextDecoration.underline,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: AppSize.width(value: 28),
//                           vertical: AppSize.width(value: 24),
//                         ),
//                         child: AppButton(
//                           borderRadius: BorderRadius.circular(12),
//                           title: "Choose Plan",
//                           filColor: isChecked
//                               ? AppColor.blue
//                               : AppColor.blue.withValues(alpha: 0.3),
//                           onTap: () {
//                             if (isChecked) {
//                               Get.toNamed(
//                                 AppRoutes
//                                     .instance
//                                     .retailerComplateSubscriptionScreen,
//                               );
//                             }

//                             if (!isChecked) {
//                               Get.snackbar(
//                                 "Terms Required",
//                                 "Please agree to terms & conditions first",
//                                 backgroundColor: Colors.red,
//                                 colorText: Colors.white,
//                               );
//                             }
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           widget.isActive
//               ? Positioned(
//                   top: 10,
//                   right: 0,
//                   child: AppImage(
//                     width: AppSize.width(value: 88),
//                     path: AssetsPath.activeCard,
//                   ),
//                 )
//               : const SizedBox(),
//         ],
//       ),
//     );
//   }
// }

class SubWidGetRow extends StatelessWidget {
  final String? text;
  const SubWidGetRow({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSize.width(value: 12),
      children: [
        Icon(
          Icons.done_rounded,
          color: AppColor.blue,
          size: AppSize.width(value: 16),
        ),
        Expanded(
          child: AppText(
            data: text ?? "No Text",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
