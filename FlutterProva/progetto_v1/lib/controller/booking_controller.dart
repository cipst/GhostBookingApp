import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:progetto_v1/controller/error_controller.dart';
import 'package:progetto_v1/controller/lesson_controller.dart';
import 'package:progetto_v1/db/booking_helper.dart';
import 'package:progetto_v1/model/booking.dart';
import 'package:progetto_v1/model/lesson.dart';

class BookingController extends GetxController {
  final lessonController = Get.put(LessonController());

  final List<Booking> bookings = <Booking>[].obs;
  final List<Lesson> lessons = <Lesson>[].obs;

  Future<int> setBooking(Booking booking) async {
    return await BookingHelper.setBooking(booking);
  }

  Future<void> completeBooking(int id, bool getAll) async {
    int updated = await BookingHelper.completeBooking(id);
    if(updated != 0){
      int index = bookings.indexWhere((b) => b.id == id);
      bookings[index].status = StatusType.complete;
      (getAll)
          ? getAllBookings(bookings[index].user)
          : getBookingByDate(bookings[index].user, DateFormat.yMd().format(lessons[index].dateTime));
    }
  }

  Future<void> cancelBooking(int id, bool getAll) async {
    int removed = await BookingHelper.cancelBooking(id);
    if(removed != 0){
      int index = bookings.indexWhere((b) => b.id == id);
      bookings[index].status = StatusType.cancel;
      (getAll)
          ? getAllBookings(bookings[index].user)
          : getBookingByDate(bookings[index].user, DateFormat.yMd().format(lessons[index].dateTime));
    }
  }

  Future<void> _getLessons() async{
    for(Booking b in bookings){
      Lesson? l = await lessonController.getLesson(b.lesson);
      (l != null) ? lessons.add(l) : null;
    }
  }

  Future<List<Booking>?> getAllBookings(String email) async {
    try {
      ErrorController.clear();
      bookings.clear();
      lessons.clear();
      List<Booking>? bookingsList = await BookingHelper.getAllBookings(email);

      if(bookingsList == null) return null;

      for (Booking b in bookingsList) {
        Lesson? l = await lessonController.getLesson(b.lesson);
        (l != null) ? lessons.add(l) : null;
        bookings.add(b);
      }

      await _getLessons();
      return bookingsList;
    } on Exception catch (e) {
      ErrorController.text.value = e.toString();
      return null;
    } on Error catch (e) {
      ErrorController.text.value = e.toString();
      return null;
    }
  }

  Future<Booking?> getBooking(int id) async {
    try {
      ErrorController.clear();
      return await BookingHelper.getBooking(id);
    } on Exception catch (e) {
      ErrorController.text.value = e.toString();
      return null;
    } on Error catch (e) {
      ErrorController.text.value = e.toString();
      return null;
    }
  }

  Future<List<Booking>?> getBookingByDate(String email, String datetime) async{
    try {
      ErrorController.clear();
      bookings.clear();
      lessons.clear();
      List<Booking>? bookingsList = await BookingHelper.getBookingByDate(email, datetime);

      if(bookingsList == null) return null;

      for (Booking b in bookingsList) {
        bookings.add(b);
      }

      await _getLessons();
      return bookingsList;
    } on Exception catch (e) {
      ErrorController.text.value = e.toString();
      return null;
    } on Error catch (e) {
      ErrorController.text.value = e.toString();
      return null;
    }
  }
}
