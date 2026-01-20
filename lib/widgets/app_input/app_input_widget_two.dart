import 'package:el_mago/const/app_const.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInputWidgetTwo extends StatefulWidget {
  const AppInputWidgetTwo({
    super.key,
    this.hintText,
    this.prefix,
    this.suffixIcon,
    this.isPassWord = false,
    this.isEmail = false,
    this.textInputAction = TextInputAction.next,
    this.controller,
    this.keyboardType,
    this.fillColor,
    this.elevation = 0.0,
    this.elevationColor,
    this.minLines = 1,
    this.readOnly = false,
    this.border,
    this.errBorder,
    this.borderRadius,
    this.contentPadding,
    this.style,
    this.maxLines,
    this.onFieldSubmitted,
    this.onTap,
    this.onChanged,
    this.isPassWordSecondValidation = false,
    this.isOptional = false,
    this.isPassWordSecondValidationController,
    this.title,
    this.validator,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.textAlignVertical,
    this.filled = true,
    this.borderColor,
    this.textColor,
    this.hintColor,

    // ✅ New optional parameters
    this.isExpiryField = false,
    this.isCvvField = false,
    this.cvvLength = 3,
    this.isCard = false, // ✅ new card field flag
  });

  final String? hintText;
  final Widget? prefix;
  final Widget? suffixIcon;
  final bool isPassWord;
  final bool readOnly;
  final bool isEmail;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final bool filled;
  final double elevation;
  final Color? elevationColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? hintColor;
  final int minLines;
  final int? maxLines;
  final InputBorder? border;
  final InputBorder? errBorder;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextAlignVertical? textAlignVertical;
  final bool isPassWordSecondValidation;
  final bool isOptional;
  final TextEditingController? isPassWordSecondValidationController;
  final String? title;
  final FormFieldValidator<String>? validator;

  // ✅ New Fields
  final bool isExpiryField;
  final bool isCvvField;
  final int cvvLength;
  final bool isCard;

  @override
  State<AppInputWidgetTwo> createState() => _AppInputWidgetTwoState();
}

class _AppInputWidgetTwoState extends State<AppInputWidgetTwo> {
  bool isShowPassWord = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.elevation,
      shadowColor: widget.elevationColor,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(
        AppSize.width(value: widget.borderRadius ?? 8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Row(
              children: [
                Text(
                  widget.title!,
                  style: TextStyle(
                    fontSize: AppSize.width(value: 14),
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppConst.fontFamily1,
                  ),
                ),
                if (!widget.isOptional)
                  Text(
                    ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: AppSize.width(value: 14),
                      fontFamily: AppConst.fontFamily1,
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 8),

          TextFormField(
            cursorColor: widget.textColor ?? Colors.black,
            onChanged: (value) {
              String formatted = value;

              // ✅ Expiry formatting logic
              if (widget.isExpiryField) {
                final text = value.replaceAll('/', '');
                formatted = '';
                if (text.length >= 2) {
                  formatted = text.substring(0, 2);
                  if (text.length > 2) {
                    // ignore: prefer_interpolation_to_compose_strings
                    formatted += '/' + text.substring(2);
                  }
                } else {
                  formatted = text;
                }

                if (formatted != widget.controller?.text) {
                  widget.controller?.value = TextEditingValue(
                    text: formatted,
                    selection: TextSelection.collapsed(
                      offset: formatted.length,
                    ),
                  );
                }
              }

              // ✅ Card formatting logic
              if (widget.isCard) {
                final digitsOnly = value.replaceAll(' ', '');
                final buffer = StringBuffer();
                for (int i = 0; i < digitsOnly.length; i++) {
                  buffer.write(digitsOnly[i]);
                  if ((i + 1) % 4 == 0 && i + 1 != digitsOnly.length) {
                    buffer.write(' ');
                  }
                }
                formatted = buffer.toString();

                if (formatted != widget.controller?.text) {
                  widget.controller?.value = TextEditingValue(
                    text: formatted,
                    selection: TextSelection.collapsed(
                      offset: formatted.length,
                    ),
                  );
                }
              }

              // 🔹 Pass final value (without spaces if card)
              widget.onChanged?.call(
                widget.isCard ? value.replaceAll(' ', '') : value,
              );
            },
            inputFormatters: [
              if (widget.isExpiryField)
                FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
              if (widget.isExpiryField) LengthLimitingTextInputFormatter(5),
              if (widget.isCvvField) FilteringTextInputFormatter.digitsOnly,
              if (widget.isCvvField)
                LengthLimitingTextInputFormatter(widget.cvvLength),
              if (widget.isCard) FilteringTextInputFormatter.digitsOnly,
              if (widget.isCard)
                LengthLimitingTextInputFormatter(19), // 16 digits + 3 spaces
            ],
            onTap: widget.onTap,
            onFieldSubmitted: widget.onFieldSubmitted,
            readOnly: widget.readOnly,
            controller: widget.controller,
            minLines: widget.minLines,
            maxLines: widget.maxLines ?? 1,
            validator: widget.validator,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            textInputAction: widget.textInputAction,
            obscureText: widget.isPassWord && isShowPassWord,
            obscuringCharacter: "*",
            textAlignVertical:
                widget.textAlignVertical ?? TextAlignVertical.center,
            style:
                widget.style ??
                TextStyle(
                  height: 2,
                  fontFamily: AppConst.fontFamily1,
                  fontWeight: FontWeight.w500,
                  color: widget.textColor ?? Colors.black,
                ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: widget.hintColor ?? Colors.black.withValues(alpha: .5),
              ),
              filled: widget.filled,
              fillColor: widget.fillColor ?? Colors.white,
              contentPadding:
                  widget.contentPadding ??
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              prefixIcon: widget.prefix != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: widget.prefix,
                    )
                  : null,
              suffixIcon: widget.isPassWord
                  ? IconButton(
                      color: Colors.black,
                      padding: EdgeInsets.zero,
                      iconSize: 16,
                      onPressed: () {
                        setState(() {
                          isShowPassWord = !isShowPassWord;
                        });
                      },
                      icon: isShowPassWord
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    )
                  : widget.suffixIcon,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? Colors.black,
                ),
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? 12.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? Colors.black,
                ),
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? 12.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? Colors.black,
                ),
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? 12.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
