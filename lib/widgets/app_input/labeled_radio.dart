import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:flutter/material.dart';

class LabeledRadio<T> extends StatelessWidget {
  final String label;
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;

  const LabeledRadio({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSize.width(value: 8),
        children: [
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: AppColor.white,
            // ignore: deprecated_member_use
            fillColor: MaterialStateProperty.resolveWith<Color>((states) {
              // ignore: deprecated_member_use
              if (states.contains(MaterialState.selected)) {
                return AppColor.button;
              }
              return AppColor.black.withValues(alpha: 0.5);
            }),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
          AppText(
            data: label,
            fontSize: AppSize.width(value: 14),
            color: AppColor.black,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
