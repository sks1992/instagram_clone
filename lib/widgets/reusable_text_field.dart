import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  const ReusableTextField({
    Key? key,
    this.isObscureText = false,
    this.hintText,
    this.textInputType = TextInputType.text,
    this.controller,
    this.required = true,
    required this.labelText,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool isObscureText;
  final bool required;
  final String? hintText;
  final String labelText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Column(
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
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: inputBorder,
            focusedBorder: inputBorder,
            enabledBorder: inputBorder,
            filled: true,
            contentPadding: const EdgeInsets.all(8),
          ),
          keyboardType: textInputType,
          obscureText: isObscureText,
        ),
      ],
    );
  }
}
