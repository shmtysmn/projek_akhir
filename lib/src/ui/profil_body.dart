import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projek_akhir/main.dart';

class ProfileBodyScreen extends StatelessWidget {
  const ProfileBodyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vokasiLightGrey = GoogleFonts.poppins(
      fontSize: 12.0,
      color: const Color(0xff8B8B8B),
    );
    var TextCardLight = GoogleFonts.poppins(
        fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal);
    /* var TextCardBold = GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white); */
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/user.png'),
            radius: 50.0,
          ),
          Text('Nama User',
              style: GoogleFonts.poppins(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: const Color(0xff484848),
              )),
          Text(
            'user@gmail.com',
            style: vokasiLightGrey,
          ),

          //card informasi
          Container(
              decoration: BoxDecoration(
                color: veppoBlue,
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('NO HP', style: TextCardLight),
                      const Spacer(),
                      Text('08973547378', style: TextCardLight),
                      const Icon(
                        Icons.copy,
                        color: Colors.white,
                        size: 18.0,
                      ),
                      const SizedBox(width: 9.0),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text('ID User', style: TextCardLight),
                      const Spacer(),
                      Text('001', style: TextCardLight),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text('Alamat', style: TextCardLight),
                      const Spacer(),
                      Text('Jl.Gajah mada', style: TextCardLight),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}