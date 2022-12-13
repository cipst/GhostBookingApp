import 'package:progetto_v1/db/db_helper.dart';
import 'package:progetto_v1/model/booking.dart';
import 'package:sqflite/sqflite.dart';

class BookingHelper {
  static final DBHelper _instance = DBHelper.instance;

  static Future<int> setBooking(Booking booking) async {
    final db = await _instance.database;

    return await db.insert("Booking", booking.toJson(),
        conflictAlgorithm: ConflictAlgorithm.abort);
  }

  static Future<List<Booking>> getAllBookings() async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.query("Booking");

    if (maps.isEmpty) throw Exception("Booking table is empty");

    List<Booking> bookings = <Booking>[];
    int i = 0;
    for (Map<String, dynamic> b in maps) {
      bookings[i++] = Booking.fromJson(b);
    }

    return bookings;
  }

  static Future<Booking> getBooking(int id) async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps =
        await db.query("Booking", where: "id = ?", whereArgs: [id]);

    if (maps.isEmpty) throw Exception("Booking table is empty");

    return Booking.fromJson(maps[0]); // only one booking, got the first one
  }
}
