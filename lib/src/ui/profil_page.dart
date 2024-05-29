import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projek_akhir/src/ui/profil_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile user',
            style: GoogleFonts.openSans(
                color: const Color(0x95484848), fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: Colors.white,
        body: ProfileBodyScreen());
  }
}
