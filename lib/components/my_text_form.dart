import 'package:flutter/material.dart';

class MyTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const MyTextForm({Key? key, required this.controller, required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          )),
      validator: (v) {
        if (v!.isEmpty) {
          return "Bo'sh qoldirish mumkin emas";
        }
      },
    );
  }
}
