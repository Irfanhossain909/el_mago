import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedValue;
  final String hint;
  final void Function(T?) onChanged;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      padding: EdgeInsets.symmetric(vertical: AppSize.width(value: 4)),
      value: selectedValue,
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // Default border (when not focused or enabled)
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.white.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(AppSize.width(value: 12)),
        ),
        // Border when enabled but not focused
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.white.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(AppSize.width(value: 12)),
        ),
        // Border when focused
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.white.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(AppSize.width(value: 12)),
        ),
        // Border when there's an error
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(AppSize.width(value: 12)),
        ),
        // Border when focused and there's an error
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(AppSize.width(value: 12)),
        ),
      ),
      style: TextStyle(color: AppColor.white),
      hint: Text(hint, style: TextStyle(color: AppColor.white)),
      items: items.map((T value) {
        return DropdownMenuItem<T>(value: value, child: Text(value.toString()));
      }).toList(),
      onChanged: onChanged,
      dropdownColor: AppColor.blue500,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColor.white,
        size: AppSize.width(value: 18),
      ),
    );
  }
}


