import 'package:chantier_plus/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/half_day.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/resource_type.dart';

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
        hintStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
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
        contentPadding: const EdgeInsets.only(top: 6, left: 14, right: 14),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          dropdownColor: AppColors.lightBackground,
          onChanged: onChanged,
          hint: Text(hintText),
          value: value,
          items: items.map<DropdownMenuItem<T>>((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(
                value.runtimeType == ResourceType
                    ? (value as ResourceType).displayName
                    : value.runtimeType == HalfDay
                        ? (value as HalfDay).displayName
                        : value.toString(),
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
