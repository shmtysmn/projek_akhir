import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projek_akhir/models/booking_data.dart';

final bookingHistoryProvider = StateProvider<List<BookingHistory>>((ref) => []);
