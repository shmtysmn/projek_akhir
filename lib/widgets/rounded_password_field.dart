import 'package:flutter/material.dart';

class RoundedPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  
  const RoundedPasswordField({
    Key? key,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        obscureText: true,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: Colors.grey[700],
          ),
          hintText: "Password",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
