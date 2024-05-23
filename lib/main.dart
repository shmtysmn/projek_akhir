import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projek_akhir/screens/login_screen.dart';
import 'package:projek_akhir/tiket_booking.dart';

// Define color constants
const kPrimaryColor = Color.fromARGB(255, 39, 241, 96);
const kPrimaryLightColor = Color(0xFFEEEEEE);
final Color veppoLightGrey = Color(0xFF999999);
final Color veppoGrey = Color(0xFF4C4C4C);
final Color veppoBlue = Color(0xFF1363FF);

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Return LoginScreen as the home if the user is not authenticated
    return MaterialApp(
      title: 'BlueBus',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimaryColor,
          primary: kPrimaryColor,
          primaryContainer: kPrimaryLightColor,
        ),
        useMaterial3: true,
      ),
      home: Consumer(builder: (context, watch, _) {
        // Check the authentication status here
        final isAuthenticated =
            false; // Replace false with your authentication logic

        // Return either the login screen or the main app based on authentication status
        return isAuthenticated ? TiketBooking() : LoginScreen();
      }),
    );
  }
}
