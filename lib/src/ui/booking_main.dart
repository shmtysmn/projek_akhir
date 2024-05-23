import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projek_akhir/src/ui/home_screen.dart';
import 'package:projek_akhir/src/ui/profil_page.dart';
import 'package:projek_akhir/src/ui/trip_page.dart';

final busTicketAppMenuIndex = StateProvider<int>((ref) => 0);

class BookingMain extends StatefulWidget {
  const BookingMain({Key? key}) : super(key: key);

  @override
  State<BookingMain> createState() => _BookingMainState();
}

class _BookingMainState extends State<BookingMain> {
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
              const HomeScreen(),
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
                label: "Pesan",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.confirmation_number,
                ),
                label: "Riwayat Pemesanan",
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
