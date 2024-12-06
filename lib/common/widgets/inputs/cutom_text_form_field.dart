import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final bool optional;
  final bool isLongText;
  final FocusNode? focusNode;
  final String? errorMessage;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.focusNode,
    this.errorMessage,
    this.optional = false,
    this.isLongText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      maxLines: isLongText
          ? 5
          : 1, // Fixe la taille visible à 5 lignes pour les textes longs
      keyboardType: isLongText ? TextInputType.multiline : TextInputType.text,
      textInputAction:
          isLongText ? TextInputAction.newline : TextInputAction.done,
      decoration: InputDecoration(
        errorText: errorMessage,
        labelText: labelText,
        hintText: hintText,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      // Active le défilement interne pour les textes longs
      scrollPhysics: const BouncingScrollPhysics(),
      scrollController: ScrollController(), // Contrôle du scrolling
    );
  }
}
