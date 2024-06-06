import 'dart:io';

import 'package:flutter/material.dart';
import 'package:studentregisterweek5/screen/details.dart';
import 'package:studentregisterweek5/screen/edit.dart';

import '../db/dbmodel.dart';
import '../db/functions.dart';

class Register extends StatefulWidget {
  const    Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _searchController = TextEditingController();
  bool isGridMode = false;

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        actions: [
          IconButton(
            icon: isGridMode
                ? const Icon(
                    Icons.list,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.grid_3x3,
                    color: Colors.white,
                  ),
            onPressed: () {
              setState(() {
                isGridMode = !isGridMode;
              });
            },
          )
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder: (BuildContext context, List<StudentModel> studentList,
              Widget? child) {
              return isGridMode
                ? GridView.builder(
                    itemCount: filtered(studentList).length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, int index) {
                      final data = filtered(studentList)[index];
                      return Card(
                        child: Column(
                          children: [
                            Center(
                              child: CircleAvatar(
                                backgroundImage: FileImage(File(data.image)),
                              ),
                            ),
                            Text(data.name),
                            Text(data.regno),
                            SizedBox(
                              width: 150,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                    
                                      alerting(data.id);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) => EditPage(
                                                  studentModel1: data)));
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                : Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                            labelText: 'Search',
                            suffixIcon: Icon(Icons.search)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, int index) {
                            final data = filtered(studentList)[index];
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(File(data.image)),
                                ),
                                title: Text(data.name),
                                subtitle: Text(data.regno),
                                trailing: SizedBox(
                                  width: 150,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          alerting(data.id);
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (ctx) => EditPage(
                                                      studentModel1: data)));
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return StudentDetails(
                                          studentModel1: studentList[index],
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          separatorBuilder: (context, int index) =>
                              const Divider(),
                          itemCount: filtered(studentList).length,
                        ),
                      ),
                    ],
                  );
          }),
    );
  }

  List<StudentModel> filtered(List<StudentModel> studentList) {
    List<StudentModel> filteredStudentList = [];

    // Use regex to filter based on name or regno
    final RegExp regExp = RegExp(_searchController.text, caseSensitive: false);

    filteredStudentList = studentList.where((student) {
      return regExp.hasMatch(student.name);
    }).toList();
    return filteredStudentList;
  }

  alerting(id) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Delete Student ?'),
            content: const Text('Are you sure?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                     deleteStudent(id);
                     Navigator.pop(ctx);
                    //snack after deteting
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(20),
                        content: Text('deleted')));
                  },
                  child: const Text('Delete'))
            ],
          );
        });
  }
}
