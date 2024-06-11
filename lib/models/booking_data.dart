class BookingData {
  static final BookingData instance = BookingData._internal();
  List<Booking> bookings = [];

  BookingData._internal();

  // Ini hanya contoh, pastikan Anda menambahkan metode untuk menambahkan pemesanan
}

class Booking {
  final String passengerName;
  final String seatNumber;
  final String busType;

  Booking({
    required this.passengerName,
    required this.seatNumber,
    required this.busType,
  });
}
