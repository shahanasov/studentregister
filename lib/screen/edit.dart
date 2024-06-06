import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentregisterweek5/db/dbmodel.dart';
import '../db/functions.dart';
import 'registeredstudent.dart';

class EditPage extends StatefulWidget {
  StudentModel studentModel1;
  EditPage({super.key, required this.studentModel1});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late StudentModel studentModel;
  final _formkey = GlobalKey<FormState>();

  late TextEditingController _nameController;

  late TextEditingController _agecontroller;

  late TextEditingController _regnoController;
  @override
  void initState() {
    studentModel = widget.studentModel1;
    _nameController = TextEditingController(text: studentModel.name);
    _agecontroller = TextEditingController(text: studentModel.age);
    _regnoController = TextEditingController(text: studentModel.regno);
    // TODO: implement initState
    super.initState();
  }

//  final StudentModel studentModel;
  late XFile _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.of(context).push(
        //           MaterialPageRoute(
        //             builder: (context) {
        //               return const Register();
        //             },
        //           ),
        //         );
        //       },
        //       icon: const Icon(Icons.person))
        // ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(File(studentModel.image)),
                      ),
                      IconButton(
                          onPressed: () {
                            pickImage();
                          },
                          icon: const Icon(Icons.add_a_photo)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Edit Your name';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Edit your Name',
                        labelText: 'Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _agecontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Edit your age';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Edit Your Age',
                        labelText: 'Age'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _regnoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Edit Your RegisterNumber';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Edit Your RegisterNumber',
                        labelText: 'RegisterNumber'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // print('object1');
                      chekingReg(context);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const Register()));
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future pickImage() async {
    final image = ImagePicker();
    XFile? returendImage = await image.pickImage(source: ImageSource.gallery);

    if (returendImage == null) return;
    setState(() {
      _selectedImage = XFile(returendImage.path);
      studentModel.image = _selectedImage.path;
      // widget._image = _selectedImage.toString();
    });
  }

  chekingReg(context) async {
    //print('object2');
    final _name = _nameController.text.trim();
    final _age = _agecontroller.text.trim();
    final _regno = _regnoController.text.trim();

   // print("object");

    final image = studentModel.image;

    if (_formkey.currentState!.validate() && !image.isEmpty) {
      final _student =
          StudentModel(name: _name, age: _age, regno: _regno, image: image);
     // print(studentModel.id);
      await updateStudent(_student, studentModel.id);
    }
  }
}
