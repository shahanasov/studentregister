import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:studentregisterweek5/db/dbmodel.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

late Database _db;

Future initializeDatabase() async {
  _db = await openDatabase(
    'student.db',
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age TEXT, regnum TEXT,image TEXT)');
    },
  );
}

Future<void> addStudent(StudentModel value) async {
  await _db.rawInsert(
      'INSERT INTO student(name, age, regnum,image) VALUES(?, ?, ?,?)',
      [value.name, value.age, value.regno, value.image]);
  await getAllStudents();
  studentListNotifier.value.add(value);

  studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final values = await _db.rawQuery('SELECT * FROM student');

  studentListNotifier.value.clear();

  for (var map in values) {
    final student = StudentModel.fromMap(map);
    studentListNotifier.value.add(student);
    studentListNotifier.notifyListeners();
  }
}

Future<void> deleteStudent(int id) async {
  _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);

  studentListNotifier.value.clear();

  studentListNotifier.notifyListeners();

  await getAllStudents();
}

Future<void> updateStudent(StudentModel studentModel, id) async {
  await _db.rawUpdate(
      'UPDATE student SET name = ?, age = ?,regnum=?,image=? WHERE id = ?', [
    studentModel.name,
    studentModel.age,
    studentModel.regno,
    studentModel.image,
    id
  ]);

  studentListNotifier.value.clear();

  studentListNotifier.notifyListeners();
  await getAllStudents();
}
