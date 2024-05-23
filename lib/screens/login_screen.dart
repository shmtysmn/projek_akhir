import 'package:flutter/material.dart';
import 'package:projek_akhir/tiket_booking.dart';
import 'package:projek_akhir/components/under_part.dart';
import 'package:projek_akhir/components/upside.dart';
import 'package:projek_akhir/components/page_title_bar.dart';
import 'package:projek_akhir/screens/signup_screen.dart';
import 'package:projek_akhir/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  // Metode untuk memeriksa apakah email valid
  bool _isEmailValid(String email) {
    return email.contains('@') && email.contains('.com');
  }

  // Metode untuk memeriksa apakah password valid (minimal 8 karakter)
  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
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
                  imgUrl: "assets/images/bus-2.png",
                ),
                const PageTitleBar(title: 'Login to your account'),
                Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 15),
                        iconButton(context),
                        const SizedBox(height: 20),
                        const Text(
                          "or use your email account",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'OpenSans',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Column(
                          children: [
                            RoundedInputField(
                              hintText: "Email",
                              icon: Icons.email,
                              controller: _emailController,
                            ),
                            RoundedPasswordField(
                              controller: _passwordController,
                            ),
                            switchListTile(),
                            RoundedButton(
                              text: 'LOGIN',
                              press: () {
                                String email = _emailController.text;
                                String password = _passwordController.text;
                                if (email.isNotEmpty && password.isNotEmpty) {
                                  if (_isEmailValid(email) && _isPasswordValid(password)) {
                                    // Navigasi jika valid
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>  TiketBooking(),
                                      ),
                                    );
                                  } else {
                                    // Tampilkan pesan kesalahan jika tidak valid
                                    _showErrorSnackbar(
                                      'Please enter a valid email (nama@gmail.com) and password (minimum 8 characters)',
                                    );
                                  }
                                } else {
                                  // Tampilkan pesan kesalahan jika form tidak lengkap
                                  _showErrorSnackbar(
                                    'Please enter email and password',
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            UnderPart(
                              title: "Don't have an account?",
                              navigatorText: "Register here",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
        value: _rememberMe,
        activeColor: Theme.of(context).primaryColor,
        onChanged: (val) {
          setState(() {
            _rememberMe = val;
          });
        },
      ),
    );
  }
}
