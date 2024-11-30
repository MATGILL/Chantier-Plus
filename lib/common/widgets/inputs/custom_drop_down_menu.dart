import 'package:chantier_plus/features/resource_mangement/domain/entities/resource_type.dart';
import 'package:flutter/material.dart';

class CustomDropdownMenu<T> extends StatelessWidget {
  final String labelText;
  final String hintText;
  final List<T> items;
  final ValueChanged<T?>? onChanged;
  final String? errorText;
  final T? value;

  const CustomDropdownMenu({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.items,
    this.value,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        errorText: errorText,
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
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          onChanged: onChanged,
          hint: Text(hintText),
          isExpanded: true,
          value: value,
          items: items.map<DropdownMenuItem<T>>((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(value.runtimeType == ResourceType
                  ? (value as ResourceType).displayName
                  : value.toString()),
            );
          }).toList(),
        ),
      ),
    );
  }
}
