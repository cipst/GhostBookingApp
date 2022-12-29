import 'package:get/get.dart';
import 'package:progetto_v1/db/booking_helper.dart';
import 'package:progetto_v1/model/booking.dart';

class BookingController extends GetxController {
  final errorText = "".obs;
  final List<Booking> bookings = <Booking>[].obs;

  void clearError() => errorText.value = "";

  Future<int> setBooking(Booking booking) async {
    return await BookingHelper.setBooking(booking);
  }

  void getAllBookings() async {
    try {
      clearError();
      List<Booking> bookingsList = await BookingHelper.getAllBookings();
      for (Booking b in bookingsList) {
        bookings.add(b);
      }
    } on Exception catch (e) {
      errorText.value = e.toString();
    }
  }

  Future<Booking?> getBooking(int id) async {
    try {
      clearError();
      return await BookingHelper.getBooking(id);
    } on Exception catch (e) {
      errorText.value = e.toString();
      return null;
    }
  }
}
