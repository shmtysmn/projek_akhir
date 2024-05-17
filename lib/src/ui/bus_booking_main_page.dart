import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projek_akhir/src/ui/bus_booking_home_screen.dart';
import 'package:projek_akhir/src/ui/bus_booking_profile_screen.dart';
import 'package:projek_akhir/src/ui/bus_booking_trip_page.dart';

final busTicketAppMenuIndex = StateProvider<int>((ref) => 0);

class BusBookingMainPage extends StatefulWidget {
  const BusBookingMainPage({Key? key}) : super(key: key);

  @override
  State<BusBookingMainPage> createState() => _BusBookingMainPageState();
}

class _BusBookingMainPageState extends State<BusBookingMainPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final index = ref.watch(busTicketAppMenuIndex);
      return Scaffold(
        body: SafeArea(
          top: true,
          child: IndexedStack(
            index: index,
            children: [
              const BusBookingHomeScreen(),
              TripsPage(),
              const ProfileScreen(),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            elevation: 4,
            selectedItemColor: Colors.red,
            currentIndex: index,
            onTap: (idx) =>
                ref.read(busTicketAppMenuIndex.notifier).state = idx,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: "Booking",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.confirmation_number,
                ),
                label: "Tickets",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_2_outlined,
                ),
                label: "Profile",
              ),
            ],
          ),
        ),
      );
    });
  }
}
