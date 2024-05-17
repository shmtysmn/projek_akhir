import 'package:flutter/material.dart';
import 'package:projek_akhir/main.dart';
import 'package:projek_akhir/widgets/text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  const RoundedPasswordField({Key? key}) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: isObscure,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            ),
            hintText: "Password",
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
            border: InputBorder.none),
      ),
    );
  }
}
