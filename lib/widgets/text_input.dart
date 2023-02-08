import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInput extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool isNumber;
  final bool obscureText;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final bool enableInteractiveSelection;
  final Function()? onTap;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLength;
  final double bottomMargin;
  final Color? fillColor;
  final bool? enabled;
  final bool required;
  final bool visible;
  final Function(String)? onFieldSubmitted;
  final int maxLines;
  final bool isDense;
  final String? hintText;
  final bool isDecimal;

  const TextInput({
    Key? key,
    required this.labelText,
    this.controller,
    this.isNumber = false,
    this.obscureText = false,
    this.focusNode,
    this.onEditingComplete,
    this.prefix,
    this.suffixIcon,
    this.prefixIcon,
    this.enableInteractiveSelection = true,
    this.onTap,
    this.maxLength,
    this.bottomMargin = 8,
    this.fillColor = const Color(0xFFEEEEEE),
    this.enabled = true,
    this.required = true,
    this.visible = true,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.isDense = false,
    this.hintText,
    this.isDecimal = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText.isNotEmpty)
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(text: labelText),
                  if (required)
                    const TextSpan(
                        text: ' *',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          const SizedBox(height: 2),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: isNumber
                ? TextInputType.numberWithOptions(
                    decimal: isDecimal, signed: false)
                : TextInputType.text,
            inputFormatters: isNumber && !isDecimal
                ? [FilteringTextInputFormatter.digitsOnly]
                : null,
            textInputAction: TextInputAction.next,
            style: const TextStyle(color: Colors.black),
            cursorColor: Colors.black54,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              isDense: isDense,
              counter: const SizedBox.shrink(),
              labelStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              fillColor:
                  enabled != null && !enabled! ? Colors.grey.shade200 : null,
              filled: enabled != null && !enabled!,
              prefix: prefix,
              suffixIcon: suffixIcon,
              hintText: hintText,
              contentPadding: enabled != null && enabled!
                  ? const EdgeInsets.symmetric(vertical: 8, horizontal: 8)
                  : null,
              enabledBorder: enabled != null && enabled!
                  ? OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.3)),
                    )
                  : null,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.withOpacity(0.3)),
              ),
            ),
            focusNode: focusNode,
            onEditingComplete: onEditingComplete,
            enableInteractiveSelection: enableInteractiveSelection,
            onTap: onTap,
            maxLength: maxLength,
            enabled: enabled,
            onFieldSubmitted: onFieldSubmitted,
            maxLines: maxLines,
          ),
          if (bottomMargin > 0) SizedBox(height: bottomMargin),
        ],
      ),
    );
  }
}
