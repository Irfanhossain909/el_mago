import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:flutter/material.dart';

class CustomDropdownWithMap extends StatelessWidget {
  final Map<int, String> items;
  final int selectedValue;
  final String hint;
  final void Function(int) onChanged;

  const CustomDropdownWithMap({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    items.entries.map((value) => DropdownMenuItem(child: Text(value.value)));
    return DropdownButtonFormField<int>(
      padding: EdgeInsets.symmetric(vertical: AppSize.width(value: 4)),
      value: selectedValue,
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // Default border (when not focused or enabled)
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.black),
          borderRadius: BorderRadius.circular(AppSize.width(value: 12)),
        ),
        // Border when enabled but not focused
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.black),
          borderRadius: BorderRadius.circular(AppSize.width(value: 12)),
        ),
        // Border when focused
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.black),
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
      style: TextStyle(color: AppColor.black),
      hint: Text(hint, style: TextStyle(color: AppColor.black)),
      items: items.entries
          .map(
            (value) => DropdownMenuItem<int>(
              value: value.key,
              child: Text(value.value),
            ),
          )
          .toList(),
      onChanged: (value) {
        onChanged(value ?? 0);
      },

      dropdownColor: AppColor.white,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColor.black,
        size: AppSize.width(value: 18),
      ),
    );
  }
}
