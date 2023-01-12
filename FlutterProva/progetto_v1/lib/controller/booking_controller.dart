import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:progetto_v1/controller/error_controller.dart';
import 'package:progetto_v1/controller/lesson_controller.dart';
import 'package:progetto_v1/controller/user_controller.dart';
import 'package:progetto_v1/db/booking_helper.dart';
import 'package:progetto_v1/model/booking.dart';
import 'package:progetto_v1/model/lesson.dart';

class BookingController extends GetxController {
  final lessonController = Get.put(LessonController());

  final List<Booking> bookings = <Booking>[].obs;
  final List<Lesson> lessons = <Lesson>[].obs;
  final keys = [].obs;

  Future<int> setBooking(Booking booking) async {
    return await BookingHelper.setBooking(booking);
  }

  Future<void> completeBooking(int id) async {
    int updated = await BookingHelper.completeBooking(id);
    if(updated != 0){
      int index = bookings.indexWhere((b) => b.id == id);
      bookings[index].status = StatusType.complete;
      getAllBookings(bookings[index].user);
    }
  }

  Future<void> cancelBooking(int id) async {
    int removed = await BookingHelper.cancelBooking(id);
    if(removed != 0){
      int index = bookings.indexWhere((b) => b.id == id);
      bookings[index].status = StatusType.cancel;
      getAllBookings(bookings[index].user);
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
      keys.clear();
      List<Booking>? bookingsList = await BookingHelper.getAllBookings(email);

      if(bookingsList == null) return null;

      for (Booking b in bookingsList) {
        bookings.add(b);
        keys.add(GlobalKey(debugLabel: "${b.id}"));
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
      keys.clear();
      List<Booking>? bookingsList = await BookingHelper.getBookingByDate(email, datetime);

      if(bookingsList == null) return null;

      for (Booking b in bookingsList) {
        bookings.add(b);
        keys.add(GlobalKey(debugLabel: "${b.id}"));
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
