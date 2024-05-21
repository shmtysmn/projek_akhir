import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projek_akhir/screens/login_screen.dart';
import 'package:projek_akhir/tiket_booking.dart';

class ProfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Text('Login Screen'),
      ),
    );
  }
}

class ProfileBodyScreen extends StatelessWidget {
  const ProfileBodyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vokasiLightGrey = GoogleFonts.poppins(
      fontSize: 12.0,
      color: const Color(0xff8B8B8B),
    );
    var textCardLight = GoogleFonts.poppins(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.normal,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
            },
          ),
        ],
      ),
      body: SizedBox(
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
            Container(
              decoration: BoxDecoration(
                color: Colors.blue, // Changed color for testing
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('NO HP', style: textCardLight),
                      const Spacer(),
                      Text('08973547378', style: textCardLight),
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
                      Text('ID User', style: textCardLight),
                      const Spacer(),
                      Text('001', style: textCardLight),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text('Alamat', style: textCardLight),
                      const Spacer(),
                      Text('Jl.Gajah mada', style: textCardLight),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text('Password', style: textCardLight),
                      const Spacer(),
                      Text('234555', style: textCardLight),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phone = '';
  String _password = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                initialValue: _name,
                onSaved: (value) => _name = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                initialValue: _email,
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => _email = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                initialValue: _phone,
                keyboardType: TextInputType.phone,
                onSaved: (value) => _phone = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                initialValue: _password, // Ganti dengan nilai awal password jika ada
                obscureText: true, // Untuk menyembunyikan teks password
                onSaved: (value) => _password = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  // Tambahkan validasi tambahan sesuai kebutuhan
                  return null;
                },
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Profile updated successfully!'),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
