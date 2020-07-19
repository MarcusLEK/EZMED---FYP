import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: const OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.grey, width: 2.0)
  ),
  focusedBorder: const OutlineInputBorder( // Makes border stay if clicked
    borderSide: const BorderSide(color: Colors.blue, width: 3.0)
  )
);