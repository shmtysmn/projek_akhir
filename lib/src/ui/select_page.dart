import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:projek_akhir/src/ui/tiket_page.dart';
import 'package:projek_akhir/models/booking_data.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({Key? key}) : super(key: key);

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  String? _selectedSeat;
  String? _tipeBus;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _onSeatTap(String seatNumber) {
    setState(() {
      if (_selectedSeat == seatNumber) {
        _selectedSeat = null; // Deselect if the seat is already selected
      } else {
        _selectedSeat = seatNumber; // Select the new seat
      }
    });
  }

  void _showBookingSuccessNotification(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pemesanan berhasil'),
        duration: Duration(
            seconds: 2), // Sesuaikan durasi notifikasi sesuai kebutuhan
      ),
    );
  }

  /* void _navigateToPage(BuildContext context) {
    // Ubah bagian ini sesuai dengan navigasi yang diinginkan
    Map<String, String> bookingData = {
      'passengerName': _nameController.text,
      'seatNumber': _selectedSeat!,
      'busType': _tipeBus!,
    };

    BookingData.instance.addBooking(bookingData);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TripTicketPage(
          passengerName: _nameController.text,
          seatNumber: _selectedSeat!,
          busType: _tipeBus!,
        ),
      ),
    );
  } */

  void _showConfirmationForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi bangku $_selectedSeat'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _nikController,
                  decoration: const InputDecoration(
                    labelText: 'NIK',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'No telpon',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Pilih Tipe Bus:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Tipe Bus',
                    border: OutlineInputBorder(),
                  ),
                  value: _tipeBus,
                  onChanged: (newValue) {
                    setState(() {
                      _tipeBus = newValue!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 'Merah',
                      child: Text('Merah'),
                    ),
                    DropdownMenuItem(
                      value: 'putih',
                      child: Text('putih'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _submitBooking();
              },
              child: Text(
                'Konfirmasi',
              ),
            ),
          ],
        );
      },
    );
  }

  void _submitBooking() async {
    final bookingData = {
      'passengerName': _nameController.text,
      'seatNumber': _selectedSeat,
      'busType': _tipeBus,
    };

    final response = await http.post(
      Uri.parse('http://192.168.1.5/ApiFlutter2/pemesanan.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bookingData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['message'] == 'Pemesanan berhasil disimpan') {
        _showBookingSuccessNotification(
            context); // Menampilkan notifikasi pemesanan berhasil
        Navigator.pop(context); // Kembali ke halaman awal
      } else {
        print('Error: ${responseBody['message']}');
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Pilih Kursi"),
        titleTextStyle: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.pop();
          },
          color: Colors.red,
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const Text(
                  "Tersedia",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.clear,
                    ),
                  ),
                ),
                const Text(
                  "Sudah dipesan",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(42.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _buildSeat("1", Colors.red),
                          _buildSeat("2", Colors.red),
                          Spacer(),
                          _buildSeat("3", Colors.red),
                          _buildSeat("4", Colors.red),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildSeat("5", Colors.red),
                          _buildSeat("6", Colors.red),
                          Spacer(),
                          _buildSeat("7", Colors.red),
                          _buildSeat("8", Colors.red),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildSeat("9", Colors.red),
                          _buildSeat("10", Colors.red),
                          Spacer(),
                          _buildSeat("11", Colors.red),
                          _buildSeat("12", Colors.red),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildSeat("13", Colors.red),
                          _buildSeat("14", Colors.red),
                          Spacer(),
                          _buildSeat("15", Colors.red),
                          _buildSeat("16", Colors.red),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildSeat("17", Colors.red),
                          _buildSeat("18", Colors.red),
                          Spacer(),
                          _buildSeat("19", Colors.red),
                          _buildSeat("20", Colors.red),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildSeat("21", Colors.red),
                          _buildSeat("22", Colors.red),
                          Spacer(),
                          _buildSeat("23", Colors.red),
                          _buildSeat("24", Colors.red),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildSeat("25", Colors.red),
                          _buildSeat("26", Colors.red),
                          Spacer(),
                          _buildSeat("27", Colors.red),
                          _buildSeat("28", Colors.red),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildSeat("29", Colors.red),
                          _buildSeat("30", Colors.red),
                          Spacer(),
                          _buildSeat("31", Colors.red),
                          _buildSeat("32", Colors.red),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 84,
        child: BottomAppBar(
          elevation: 64,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Row(
              children: [
                Text(
                  "Seat: ${_selectedSeat ?? 'None'}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (_selectedSeat != null) {
                        _showConfirmationForm(
                            context); // Handle confirmation action
                      }
                    },
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                        color: _selectedSeat != null ? Colors.red : Colors.grey,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: const Center(
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
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

  Widget _buildSeat(String seatNumber, Color borderColor,
      {bool taken = false}) {
    return GestureDetector(
      onTap: taken
          ? null
          : () {
              _onSeatTap(seatNumber);
            },
      child: Container(
        height: 48,
        width: 48,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          border: taken ? null : Border.all(color: borderColor, width: 3),
          color: taken
              ? Colors.grey[400]
              : (_selectedSeat == seatNumber ? Colors.green : Colors.white),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: taken
              ? const Icon(
                  Icons.clear,
                  color: Colors.white,
                )
              : Text(
                  seatNumber,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
        ),
      ),
    );
  }
}
