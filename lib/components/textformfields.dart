import 'package:flutter/material.dart';

// ignore: camel_case_types
class customTextFeild extends StatelessWidget {
  final String hintText;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;
  const customTextFeild({
    super.key,
    required this.hintText,
    required this.mycontroller,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final fill = isDark ? Colors.grey[800] : Colors.grey[200];
    final hintColor = isDark ? Colors.grey[400] : Colors.grey[700];
    final borderColor = theme.colorScheme.onSurface.withOpacity(0.12);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: TextFormField(
        validator: validator,
        controller: mycontroller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: hintColor),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          filled: true,
          fillColor: fill,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: borderColor),
          ),
        ),
      ),
    );
  }
}
