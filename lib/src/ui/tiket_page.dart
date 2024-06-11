import 'package:flutter/material.dart';
import 'package:projek_akhir/main.dart';
import 'package:projek_akhir/models/booking_data.dart';

class TripTicketPage extends StatelessWidget {
  final String passengerName;
  final String seatNumber;
  final String busType;

  TripTicketPage(
      {required this.passengerName,
      required this.seatNumber,
      required this.busType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: veppoBlue,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 32, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Booking details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Total 30.000',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 32),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
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
                        SizedBox(height: 16),
                        Text(
                          "tanggal pemesanan",
                          style: TextStyle(
                            color: veppoLightGrey,
                          ),
                        ),
                        Text('27/02/2024'),
                        SizedBox(height: 28),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tujuan Awal',
                                  style: TextStyle(color: veppoLightGrey),
                                ),
                                Text('Jember'),
                                SizedBox(height: 28),
                                Text(
                                  'Tujuan Akhir',
                                  style: TextStyle(color: veppoLightGrey),
                                ),
                                Text(' Bali'),
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Berangkat',
                                  style: TextStyle(color: veppoLightGrey),
                                ),
                                Text('6:30'),
                                SizedBox(height: 28),
                                Text(
                                  'Sampai',
                                  style: TextStyle(color: veppoLightGrey),
                                ),
                                Text('11:30'),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 28),
                    Divider(),
                    SizedBox(height: 28),
                    Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nama penumpang',
                                  style: TextStyle(color: veppoLightGrey),
                                ),
                                Text(
                                  passengerName,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(height: 28),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tipe Bus',
                                  style: TextStyle(color: veppoLightGrey),
                                ),
                                Text(
                                  busType,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'No Kursi',
                                  style: TextStyle(color: veppoLightGrey),
                                ),
                                Text(
                                  seatNumber,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Spacer(flex: 2),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 28),
                    Divider(),
                    SizedBox(height: 28),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          'barccodebarcodeb',
                          style: TextStyle(
                            fontFamily: 'Barcode',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'ticket ID: 18128239487912',
                style: TextStyle(
                  color: veppoLightGrey,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
