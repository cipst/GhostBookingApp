import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:progetto_v1/controller/error_controller.dart';
import 'package:progetto_v1/controller/lesson_controller.dart';
import 'package:progetto_v1/db/booking_helper.dart';
import 'package:progetto_v1/model/booking.dart';
import 'package:progetto_v1/model/lesson.dart';

class BookingController extends GetxController {
  final lessonController = Get.put(LessonController());

  final Map<Booking, Lesson> bookings = <Booking, Lesson>{}.obs;
  final Map<Booking, Lesson> bookingsFiltered = <Booking, Lesson>{}.obs;

  void applyFilters(String email, Map<String, dynamic> filters){
    bookingsFiltered.clear();
    Set<Booking> byStatus = {};
    Set<Lesson>? byDate = {};
    Set<Lesson>? byTime = {};
    Set<Lesson>? byTeacher = {};
    Set<Lesson>? byCourse = {};

    if(filters.isEmpty) {
      bookingsFiltered.addAll(bookings);
      return;
    }

    filters.forEach((key, value){
      if(key == "status"){
        for(Booking b in bookings.keys){
          if(b.status == filters["status"]){
            byStatus.add(b);
          }
        }
      }
      if(key == "date"){
        for(Lesson l in bookings.values){
          if(l.dateTime.subtract(Duration(hours: l.dateTime.hour)).compareTo(filters["date"]) == 0){
            byDate!.add(l);
          }
        }
        byDate!.isEmpty ? byDate = null : null;
      }
      if(key == "time"){
        for(Lesson l in bookings.values){
          if(l.dateTime.hour.compareTo(filters["time"]) == 0){
            byTime!.add(l);
          }
        }
        byTime!.isEmpty ? byTime = null : null;
      }
      if(key == "teacher"){
        for(Lesson l in bookings.values){
          if(l.teacher.compareTo(filters["teacher"]) == 0){
            byTeacher!.add(l);
          }
        }
        byTeacher!.isEmpty ? byTeacher = null : null;
      }
      if(key == "course"){
        for(Lesson l in bookings.values){
          if(l.course.compareTo(filters["course"]) == 0){
            byCourse!.add(l);
          }
        }
        byCourse!.isEmpty ? byCourse = null : null;
      }
    });

    // lesson filter null ==> no lessons found
    if(byDate == null && byTime == null && byTeacher == null && byCourse == null){
      bookingsFiltered.clear();
      return;
    }

    // all filters empty ==> show all booked lessons
    if(byStatus.isEmpty && byDate!.isEmpty && byTime!.isEmpty && byTeacher!.isEmpty && byCourse!.isEmpty){
      bookingsFiltered.clear();
      bookingsFiltered.addAll(bookings);
      return;
    }

    Set<Lesson> newLesson = {};
    newLesson = _filter(newLesson, byDate!);
    newLesson = _filter(newLesson, byTime!);
    newLesson = _filter(newLesson, byTeacher!);
    newLesson = _filter(newLesson, byCourse!);

    // adding booked lesson filtered
    for(Lesson l in newLesson){
      try {
        Booking b = bookings.keys.firstWhere(
                (b) => byStatus.isNotEmpty
                ? byStatus.contains(b) && bookings[b] == l
                : bookings[b] == l
        );
        bookingsFiltered[b] = l;
      } on Error catch (e) {
        debugPrint(e.toString());
      }
    }

    if(newLesson.isEmpty){
      // adding booked lesson filtered only by status
      for(Booking b in byStatus){
        bookingsFiltered[b] = bookings[b]!;
      }
    }

    return;
  }

  Set<Lesson> _filter(Set<Lesson> prev, Set<Lesson> toCheck){
    if(toCheck.isNotEmpty){
      if(prev.isEmpty) {
        return toCheck;
      }else{
        return prev.intersection(toCheck);
      }
    }
    return prev;
  }

  Future<int> setBooking(Booking booking) async {
    return await BookingHelper.setBooking(booking);
  }

  Future<void> updateBookingStatus(int id, bool getAll, StatusType newStatus) async {
    int rows = await BookingHelper.updateBookingStatus(id, newStatus.index);
    if(rows != 0){
      for(Booking b in bookings.keys) {
        if(b.id == id) {
          b.status = newStatus;
          (getAll)
              ? getAllBookings(b.user)
              : getBookingByDate(b.user, DateFormat.yMd().format(bookings[b]!.dateTime));
        }
      }
    }
  }

  Future<List<Booking>?> getAllBookings(String email) async {
    try {
      ErrorController.clear();
      bookings.clear();
      bookingsFiltered.clear();
      List<Booking>? bookingsList = await BookingHelper.getAllBookings(email);

      if(bookingsList == null) return null;

      for (Booking b in bookingsList) {
        Lesson? l = await lessonController.getLesson(b.lesson);
        l != null ? bookings[b] = l : null;
      }

      bookingsFiltered.addAll(bookings);

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
      List<Booking>? bookingsList = await BookingHelper.getBookingByDate(email, datetime);

      if(bookingsList == null) return null;

      for (Booking b in bookingsList) {
        Lesson? l = await lessonController.getLesson(b.lesson);
        l != null ? bookings[b] = l : null;
      }

      return bookingsList;
    } on Exception catch (e) {
      ErrorController.text.value = e.toString();
      return null;
    } on Error catch (e) {
      ErrorController.text.value = e.toString();
      return null;
    }
  }

  Future<List<Booking>?> getBookingByStatus(String email, StatusType status) async{
    try {
      ErrorController.clear();
      bookings.clear();
      List<Booking>? bookingsList = await BookingHelper.getBookingByStatus(email, status);

      if(bookingsList == null) return null;

      for (Booking b in bookingsList) {
        Lesson? l = await lessonController.getLesson(b.lesson);
        l != null ? bookings[b] = l : null;
      }

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
