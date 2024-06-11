import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:projek_akhir/src/ui/home_screen.dart';
import 'package:projek_akhir/tiket_booking.dart';
import 'package:projek_akhir/components/under_part.dart';
import 'package:projek_akhir/components/upside.dart';
import 'package:projek_akhir/components/page_title_bar.dart';
import 'package:projek_akhir/screens/signup_screen.dart';
import 'package:projek_akhir/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MaterialApp(
    home: isLoggedIn ? HomeScreen() : LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false; // Add this to manage remember me state

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Null-safe check for _formKey.currentState
      try {
        final response = await http.post(
          Uri.parse('http://192.168.1.5/ApiFlutter2/login.php'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(<String, String>{
            'username': _emailController.text,
            'password': _passwordController.text,
          }),
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['message'] == 'Login berhasil') {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', true);
            await prefs.setString('username', data['user']['username']);
            // Save other user details as needed

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Login Berhasil"),
                  content: Text("Selamat datang, ${data['user']['username']}"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              },
            );
          } else {
            _showErrorDialog(context, data['message']);
          }
        } else {
          _showErrorDialog(context,
              'Gagal terhubung ke server. Status kode: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e'); // Logging the error
        _showSnackbar(
            context, 'Terjadi kesalahan, periksa koneksi internet Anda.');
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
                  imgUrl: "assets/images/bus-2.png",
                  text: "Blue Bus",
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
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              RoundedInputField(
                                hintText: "Email",
                                icon: Icons.email,
                                controller: _emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
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
                              switchListTile(),
                              RoundedButton(
                                text: 'LOGIN',
                                press: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    _login();
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
                                      builder: (context) =>
                                          const SignUpScreen(),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
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

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Gagal"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showErrorSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
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
