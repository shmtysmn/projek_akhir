import 'package:flutter/material.dart';

class RoundedKonfirmPassword extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const RoundedKonfirmPassword({
    Key? key,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedKonfirmPassword> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedKonfirmPassword> {
  bool isObscure = true;
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
        obscureText: isObscure,
        controller: widget.controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: Colors.grey[700],
          ),
          hintText: "konfirm Password",
          hintStyle: TextStyle(fontFamily: 'OpenSans'),
          suffixIcon: IconButton(
            icon: Icon(
              isObscure ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                isObscure = !isObscure;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
