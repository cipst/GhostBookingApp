class Queries {
  static const String createUserTable = '''
  CREATE TABLE `User` (
    `email` VARCHAR(50) PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `image` VARCHAR(60), 
    `password` VARCHAR(50) NOT NULL
  );
  ''';

  static const String createTeacherTable = '''
  CREATE TABLE `Teacher` (
    `name` VARCHAR(50) PRIMARY KEY,
    `image` VARCHAR(60) NOT NULL
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
    `teacher` INTEGER NOT NULL,
    `dateTime` VARCHAR(16) NOT NULL,
    FOREIGN KEY (`course`) REFERENCES `Course`(`name`),
    FOREIGN KEY (`teacher`) REFERENCES `Teacher`(`name`)
  );
  ''';

  // reminder is 16 char because --> yyyy-MM-dd HH:mm
  static const String createBookingTable = '''
  CREATE TABLE `Booking` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `user` INTEGER NOT NULL,
    `lesson` INTEGER NOT NULL,
    `reminder` VARCHAR(16) NOT NULL,
    `status` INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (`user`) REFERENCES `User`(`email`),
    FOREIGN KEY (`lesson`) REFERENCES `Lesson`(`id`),
    CHECK (`status` = 0 OR `status` = 1 OR `status` = 2)
  );
  ''';
}
