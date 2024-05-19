import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projek_akhir/src/ui/detail_page.dart';
import 'package:projek_akhir/src/ui/booking_main.dart';
import 'package:projek_akhir/src/ui/select_page.dart';

class TiketBooking extends StatelessWidget {
  TiketBooking({Key? key}) : super(key: key);
  final appRoute = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const BookingMain(),
        routes: [
          ShellRoute(
            routes: [
              GoRoute(
                path: "detail",
                builder: (context, state) => const DetailPage(),
              ),
              GoRoute(
                path: "seat",
                builder: (context, state) => const SelectPage(),
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
