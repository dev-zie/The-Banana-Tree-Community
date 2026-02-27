import 'package:flutter/material.dart';

class SignInUpButtonWidget extends StatelessWidget {
  const SignInUpButtonWidget({
    super.key,
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.widthOf(context) * 0.8, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(30),
        ),
        overlayColor: Colors.green,
        backgroundColor: color,
      ),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 32)),
    );
  }
}
