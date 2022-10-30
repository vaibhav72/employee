import 'package:flutter/material.dart';

class MetaStyles {
  static OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(9),
      borderSide: BorderSide(color: Colors.grey.shade100));
  static InputDecoration textFieldDecoration(String label) => InputDecoration(
      labelText: label,
      labelStyle:const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      enabledBorder:
          defaultBorder.copyWith(borderSide: BorderSide(color: Colors.black)),
      focusedBorder:
          defaultBorder.copyWith(borderSide: BorderSide(color: Colors.black)),
      border: defaultBorder);
}
