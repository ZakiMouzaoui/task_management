import 'package:flutter/material.dart';
import 'package:task_management/utils/constants.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final double radius;
  final int maxLines;
  final TextEditingController controller;
  final bool readOnly;

  const TextFieldWidget({required this.hintText, required this.radius, this.maxLines=1, Key? key, required this.controller, required this.readOnly}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      autofocus: true,
      controller: controller,
      scrollPadding: const EdgeInsets.only(bottom: 20),
      scrollPhysics: const ScrollPhysics(),
      cursorColor: AppColors.mainColor,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.textHolder,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: Colors.white
          )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(
                color: Colors.white
            )
        ),
        hintText: hintText,

      ),
    );
  }
}
