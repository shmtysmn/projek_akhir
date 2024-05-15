import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projek_akhir/src/ui/bus_booking_detail_page.dart';
import 'package:projek_akhir/src/ui/bus_booking_main_page.dart';
import 'package:projek_akhir/src/ui/bus_booking_select_page.dart';

class BusTicketBookingApp extends StatelessWidget {
  BusTicketBookingApp({Key? key}) : super(key: key);
  final appRoute = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const BusBookingMainPage(),
        routes: [
          ShellRoute(
            routes: [
              GoRoute(
                path: "detail",
                builder: (context, state) => const BusBookingDetailPage(),
              ),
              GoRoute(
                path: "seat",
                builder: (context, state) => const BusBookingSelectPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRoute,
    );
  }
}
