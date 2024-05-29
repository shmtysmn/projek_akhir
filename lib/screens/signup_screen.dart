import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projek_akhir/components/under_part.dart';
import 'package:projek_akhir/components/upside.dart';
import 'package:projek_akhir/components/page_title_bar.dart';
import 'package:projek_akhir/screens/login_screen.dart';
import 'package:projek_akhir/widgets/rounded_konfirm_password.dart';
import 'package:projek_akhir/widgets/widgets.dart';
import 'package:projek_akhir/main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _showErrors = false;

  Future<void> _register() async {
    setState(() {
      _showErrors = true;
    });

    if (_formKey.currentState!.validate() &&
        _passwordController.text == _confirmPasswordController.text) {
      try {
        final response = await http.post(
          Uri.parse('http://192.168.1.19/ApiFlutter2/register.php'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'name': _nameController.text,
            'username': _usernameController.text,
            'password': _passwordController.text,
          }),
        );

        final data = json.decode(response.body);
        if (response.statusCode == 200 &&
            data['message'] == 'Registrasi berhasil') {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Success'),
                content: Text('Registrasi berhasil!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Registrasi gagal. Silakan coba lagi.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Terjadi kesalahan. Silakan coba lagi.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                const Upside(
                    imgUrl: "assets/images/bus-2.png", text: "Blue Buss Anjay"),
                const PageTitleBar(title: 'Create new account'),
                Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        iconButton(context),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "or use your email account",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'OpenSans',
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              RoundedInputField(
                                hintText: "Username",
                                icon: Icons.person,
                                controller: _nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your username';
                                  }
                                  return null;
                                },
                              ),
                              RoundedInputField(
                                hintText: "Email",
                                icon: Icons.email,
                                controller: _usernameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                              RoundedPasswordField(
                                controller: _passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                              RoundedKonfirmPassword(
                                controller: _confirmPasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: _register,
                                child: const Text("Sign Up"),
                              ),
                              UnderPart(
                                title: "Already have an account?",
                                navigatorText: "Login here",
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget switchListTile() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 40),
      child: SwitchListTile(
        dense: true,
        title: const Text(
          'Remember me',
          style: TextStyle(fontSize: 16, fontFamily: 'OpenSans'),
        ),
        value: true,
        activeColor: kPrimaryColor,
        onChanged: (val) {},
      ),
    );
  }

  Widget iconButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        RoundedIcon(
          imageUrl: "assets/images/facebook.png",
          url: 'https://www.facebook.com/login/',
        ),
        SizedBox(
          width: 20,
        ),
        RoundedIcon(
          imageUrl: "assets/images/twitter.png",
          url: 'https://twitter.com/i/flow/login',
        ),
        SizedBox(
          width: 20,
        ),
        RoundedIcon(
          imageUrl: "assets/images/google.jpg",
          url:
              'https://myaccount.google.com/?utm_source=sign_in_no_continue&pli=1',
        ),
      ],
    );
  }
}
