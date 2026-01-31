import 'package:flutter/material.dart';

// ignore: camel_case_types
class customTextFeildadd extends StatelessWidget {
  final String hintText;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;
  const customTextFeildadd({
    super.key,
    required this.hintText,
    required this.mycontroller,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: TextFormField(
        validator: validator,
        controller: mycontroller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
