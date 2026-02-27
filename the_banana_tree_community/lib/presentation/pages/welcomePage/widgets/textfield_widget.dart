import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  const TextfieldWidget({
    super.key,
    required this.hintText,
    required this.type,
  });

  final String hintText;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.widthOf(context) * 0.8,
      padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        keyboardType: type,
        cursorHeight: 24,
        cursorColor: Colors.white,
        style: const TextStyle(fontSize: 24),
        decoration: InputDecoration(
          hintStyle: const TextStyle(),
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}
