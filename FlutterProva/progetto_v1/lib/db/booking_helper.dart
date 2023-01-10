import 'package:progetto_v1/db/db_helper.dart';
import 'package:progetto_v1/model/booking.dart';
import 'package:sqflite/sqflite.dart';

class BookingHelper {
  static final DBHelper _instance = DBHelper.instance;

  static Future<int> setBooking(Booking booking) async {
    final db = await _instance.database;

    return await db.insert("Booking", booking.toJson(), conflictAlgorithm: ConflictAlgorithm.abort);
  }

  static Future<List<Booking>?> getAllBookings(String email) async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.query("Booking", where: "user = ?", whereArgs: [email]);
    // final List<Map<String, dynamic>> maps = await db.query("Booking");

    if (maps.isEmpty) return null;

    List<Booking> bookings = <Booking>[];
    for (Map<String, dynamic> b in maps) {
      bookings.add(Booking.fromJson(b));
    }

    return bookings;
  }

  static Future<Booking?> getBooking(int id) async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.query("Booking", where: "id = ?", whereArgs: [id]);

    if (maps.isEmpty) return null;

    return Booking.fromJson(maps.first); // only one booking, got the first one
  }


  static Future<List<Booking>?> getBookingByDate(String email, String datetime) async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery("""
    SELECT b.* FROM Booking b JOIN Lesson l ON b.lesson = l.id
    WHERE b.user = ? AND l.datetime LIKE ?
    ORDER BY l.datetime, l.teacher, l.course
    """, [email, "%$datetime%"]);

    if (maps.isEmpty) return null;

    List<Booking> bookings = <Booking>[];
    for (Map<String, dynamic> b in maps) {
      bookings.add(Booking.fromJson(b));
    }

    return bookings;
  }
}
