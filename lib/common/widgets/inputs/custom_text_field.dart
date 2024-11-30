import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importation nécessaire pour les TextInputFormatters

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool isLongText;
  final ValueChanged<String>? onChanged;
  final String? erroText;
  final bool isDigit; // Nouveau paramètre pour valider les chiffres

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.isLongText = false,
    this.erroText = "",
    this.onChanged,
    this.isDigit =
        false, // Par défaut, on ne valide pas uniquement les chiffres
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: isLongText ? 5 : 1,
      keyboardType: isDigit
          ? TextInputType.number
          : TextInputType.text, // Change le type de clavier si isDigit est vrai
      inputFormatters: isDigit
          ? [
              FilteringTextInputFormatter.digitsOnly
            ] // Permet uniquement les chiffres
          : [],
      textInputAction:
          isLongText ? TextInputAction.newline : TextInputAction.done,
      onChanged: onChanged,
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
