class Queries {
  static const String createUserTable = '''
  CREATE TABLE `User` (
    `email` VARCHAR(50) PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `image` VARCHAR(60) NOT NULL, 
    `password` VARCHAR(50) NOT NULL,
    `phone` VARCHAR(20) NOT NULL
  );
  ''';

  static const String createTeacherTable = '''
  CREATE TABLE `Teacher` (
    `name` VARCHAR(50) PRIMARY KEY
  );
  ''';

  static const String createCourseTable = '''
  CREATE TABLE `Course` (
    `name` VARCHAR(50) PRIMARY KEY
  );
  ''';

  // dateTime is 16 char because --> yyyy-MM-dd HH:mm
  static const String createLessonTable = '''
  CREATE TABLE `Lesson` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `course` VARCHAR(50) NOT NULL,
    `teacher` VARCHAR(50) NOT NULL,
    `dateTime` VARCHAR(16) NOT NULL,
    FOREIGN KEY (`course`) REFERENCES `Course`(`name`),
    FOREIGN KEY (`teacher`) REFERENCES `Teacher`(`name`)
  );
  ''';

  // reminder is 16 char because --> yyyy-MM-dd HH:mm
  // status: 0 -> active | 1 -> done | 2 -> canceled
  static const String createBookingTable = '''
  CREATE TABLE `Booking` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `user` VARCHAR(50) NOT NULL,
    `lesson` INTEGER NOT NULL,
    `reminder` VARCHAR(16),
    `status` INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (`user`) REFERENCES `User`(`email`),
    FOREIGN KEY (`lesson`) REFERENCES `Lesson`(`id`),
    CHECK (`status` = 0 OR `status` = 1 OR `status` = 2)
  );
  ''';

  static const String getLessons = '''
  SELECT l.* FROM Lesson l LEFT JOIN Booking b ON l.id == b.lesson
  ''';
}
