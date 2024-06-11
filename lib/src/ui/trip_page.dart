import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';

class TripsPage extends StatefulWidget {
  @override
  _TripsPageState createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  List<dynamic> _bookings = [];

  @override
  void initState() {
    super.initState();
    _fetchBookingHistory();
  }

  Future<void> _fetchBookingHistory() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.5/ApiFlutter2/trip.php'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _bookings = jsonData['pemesanan'];
      });
    } else {
      print('Failed to load booking history');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking History'),
      ),
      body: _bookings.isNotEmpty
          ? ListView.builder(
              itemCount: _bookings.length,
              itemBuilder: (context, index) {
                final booking = _bookings[index];
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle onTap event
                        },
                        child: Container(
                          padding: EdgeInsets.all(26),
                          margin: EdgeInsets.fromLTRB(26, 26, 26, 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Image.asset(
                                      'assets/images/gol_logo.png',
                                    ),
                                  ),
                                  SizedBox(height: 28),
                                  SizedBox(height: 28),
                                  Row(
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Passenger Name:',
                                              style: TextStyle(
                                                  color: veppoLightGrey),
                                            ),
                                            Text(booking['passengerName']),
                                            // Properti dinamis
                                            SizedBox(height: 16),
                                            Text(
                                              'Number Seat:',
                                              style: TextStyle(
                                                  color: veppoLightGrey),
                                            ),
                                            Text(booking['seatNumber'])
                                          ]),
                                      Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Bus Type:',
                                            style: TextStyle(
                                                color: veppoLightGrey),
                                          ),
                                          Text(booking[
                                              'busType']), // Properti dinamis
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : Center(child: Text('No booking history available')),
    );
  }
}
