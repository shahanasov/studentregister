import 'dart:io';

import 'package:flutter/material.dart';

import '../db/dbmodel.dart';
import '../db/functions.dart';

class StudentDetails extends StatelessWidget {
  final StudentModel studentModel1;
  const StudentDetails({super.key, required this.studentModel1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Studnet Details'),
      ),
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ValueListenableBuilder(
              valueListenable: studentListNotifier,
              builder: (BuildContext context, studentModel, Widget? child) {
                
                return  Card(
                  elevation: 10,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  color: const Color.fromARGB(255, 153, 203, 227),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                         CircleAvatar(
                          radius: 90,
                          backgroundImage: FileImage(File(studentModel1.image)
                              ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          studentModel1.name,
                          style: const TextStyle(fontSize: 30),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                         Text(
                          studentModel1.age,
                          style:const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                         Text(
                          studentModel1.regno,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        )),
      ),
    );
  }
}
