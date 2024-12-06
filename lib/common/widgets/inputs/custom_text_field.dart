import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importation nécessaire pour les TextInputFormatters

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool isLongText;
  final ValueChanged<String>? onChanged;
  final Function()? onTap;
  final String? erroText;
  final bool isDigit;
  final bool readOnly;
  final String? initialValue;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.isLongText = false,
    this.erroText = "",
    this.onChanged,
    this.onTap,
    this.isDigit = false,
    this.readOnly = false,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      maxLines: isDigit
          ? 1
          : isLongText
              ? 5
              : 1,
      keyboardType: isDigit
          ? TextInputType.number
          : isLongText
              ? TextInputType.multiline
              : TextInputType.text,
      inputFormatters: isDigit ? [FilteringTextInputFormatter.digitsOnly] : [],
      textInputAction:
          isLongText ? TextInputAction.newline : TextInputAction.done,
      onChanged: onChanged,
      onTap: onTap,
      controller: initialValue != null
          ? TextEditingController(text: initialValue)
          : null, // Assigner la valeur initiale
      decoration: InputDecoration(
        errorText: erroText,
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
      scrollPhysics: const BouncingScrollPhysics(),
      scrollController: ScrollController(),
    );
  }
}
