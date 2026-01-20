import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:flutter/material.dart';

class AppDescriptionTextField extends StatelessWidget {
  const AppDescriptionTextField({
    super.key,
    this.controller,
    this.hintText = '',
    this.fillColor,
    this.title,
    this.titleColor,
    this.hintColor,
    this.textColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
  });

  final String? title;
  final TextEditingController? controller;
  final String hintText;
  final Color? fillColor;
  final Color? titleColor;
  final Color? hintColor;
  final Color? textColor;

  /// Border color parameters
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;

  @override
  Widget build(BuildContext context) {
    // Default border colors
    final Color defaultBorderColor = borderColor ?? AppColor.black;
    final Color defaultFocusedBorderColor = focusedBorderColor ?? AppColor.black;
    final Color defaultErrorBorderColor = errorBorderColor ?? Colors.red;

    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: defaultBorderColor, width: 1.2),
    );

    final focusedOutlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: defaultFocusedBorderColor, width: 1.4),
    );

    final errorOutlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: defaultErrorBorderColor, width: 1.4),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (title == null || title!.isEmpty)
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: AppText(
                  data: title!,
                  fontWeight: FontWeight.w600,
                  color: titleColor ?? Colors.black,
                  fontSize: AppSize.width(value: 16),
                ),
              ),
        const Gap(height: 10),
        SizedBox(
          height: 120,
          child: TextFormField(
            cursorColor: Colors.black,
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            style: TextStyle(color: textColor ?? Colors.black),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: AppSize.width(value: 16),
                color: hintColor ?? AppColor.black.withValues(alpha: 0.5),
              ),
              filled: true,
              fillColor: fillColor ?? AppColor.white,
              border: outlineBorder,
              enabledBorder: outlineBorder,
              focusedBorder: focusedOutlineBorder,
              errorBorder: errorOutlineBorder,
              focusedErrorBorder: errorOutlineBorder,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}



// import 'package:el_mago/const/app_color.dart';
// import 'package:el_mago/utils/app_size.dart';
// import 'package:el_mago/widgets/app_log/gap.dart';
// import 'package:el_mago/widgets/app_text/app_text.dart';
// import 'package:flutter/material.dart';

// class AppDescriptionTextField extends StatelessWidget {
//   const AppDescriptionTextField({
//     super.key,
//     this.controller,
//     this.hintText = '',
//     this.fillColor,
//     this.border,
//     this.errBorder,
//     this.title,
//     this.titleColor,
//     this.hintColor,
//     this.textColor,
//   });

//   final String? title;
//   final TextEditingController? controller;
//   final String hintText;
//   final Color? fillColor;
//   final Color? titleColor;
//   final Color? hintColor;
//   final Color? textColor;
//   final InputBorder? border;
//   final InputBorder? errBorder;

//   @override
//   Widget build(BuildContext context) {
//     final outlineBorder = OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8),
//       borderSide: BorderSide(color: AppColor.black.withValues(alpha: .5)),

//       // No border color
//     );

//     final errorOutlineBorder = OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8),
//       borderSide: BorderSide.none, // No border color
//     );

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // const Gap(height: 15),
//         // Show SizedBox if title is null or empty, otherwise show AppText
//         (title == null || title!.isEmpty)
//             ? const SizedBox()
//             : Padding(
//                 padding: EdgeInsets.symmetric(vertical: 4.0),
//                 child: AppText(
//                   data: title!,
//                   fontWeight: FontWeight.w600,
//                   color: titleColor ?? Colors.black,
//                   fontSize: AppSize.width(value: 16),
//                 ),
//               ),

//         const Gap(height: 10),
//         SizedBox(
//           height: 120,
//           child: TextFormField(
//             cursorColor: Colors.black,
//             controller: controller,
//             keyboardType: TextInputType.multiline,
//             maxLines: null,
//             expands: true,
//             textAlignVertical: TextAlignVertical.top,
//             decoration: InputDecoration(
//               hintText: hintText,
//               hintStyle: TextStyle(
//                 fontSize: AppSize.width(value: 16),
//                 color: hintColor ?? AppColor.black.withValues(alpha: 0.5),
//               ),

//               filled: true,
//               fillColor: fillColor ?? AppColor.white,
//               border: border ?? outlineBorder,
//               enabledBorder: border ?? outlineBorder,
//               focusedBorder: border ?? outlineBorder,
//               errorBorder: errBorder ?? errorOutlineBorder,
//               focusedErrorBorder: errBorder ?? errorOutlineBorder,
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'This field is required';
//               }
//               return null;
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
