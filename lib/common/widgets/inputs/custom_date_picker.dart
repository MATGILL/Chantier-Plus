import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final String labelText;
  final String hintText;
  final DateTime? initialDate;
  final ValueChanged<DateTime> onDateSelected;
  final String? errorText;

  const CustomDatePicker({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.initialDate,
    required this.onDateSelected,
    this.errorText,
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickDate,
      child: AbsorbPointer(
        child: TextField(
          readOnly: true,
          controller: TextEditingController(
            text: _selectedDate != null ? _formatDate(_selectedDate!) : '',
          ),
          decoration: InputDecoration(
            errorText: widget.errorText,
            labelText: widget.labelText,
            hintText: widget.hintText,
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
            suffixIcon: const Icon(
              Icons.calendar_today,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      widget.onDateSelected(pickedDate);
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
}
