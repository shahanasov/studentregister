import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentregisterweek5/db/dbmodel.dart';
import 'package:studentregisterweek5/db/functions.dart';
import 'package:studentregisterweek5/screen/registeredstudent.dart';

final _formkey = GlobalKey<FormState>();

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
 const HomeScreen({
    super.key,
  });
// Uint8List? _image;
// String _image = '';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameController = TextEditingController();

  final agecontroller = TextEditingController();

  final regnoController = TextEditingController();

//  final StudentModel studentModel;
  late XFile _selectedImage;

  Future pickImage() async {
    final image = ImagePicker();
    XFile? returendImage = await image.pickImage(source: ImageSource.gallery);

    if (returendImage == null) return;
    setState(() {
      _selectedImage = XFile(returendImage.path);
      // widget._image = _selectedImage.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Register'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const Register();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.person))
        ],
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
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            'https://tse4.mm.bing.net/th?id=OIP.xhqNmlH25J_0xR-mZNcSZgHaHa&pid=Api&P=0&h=180%27'),
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
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Your name';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your Name',
                        labelText: 'Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: agecontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your age';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Your Age',
                        labelText: 'Age'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: regnoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Your RegisterNumber';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Your RegisterNumber',
                        labelText: 'RegisterNumber'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                    
                      chekingReg(context);
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  chekingReg(context) async {
   
    final name = nameController.text.trim();
    final age = agecontroller.text.trim();
    final regno = regnoController.text.trim();
    final image = _selectedImage.path.toString();

    if (_formkey.currentState!.validate() && image.isNotEmpty) {
      final student =
          StudentModel(name: name, age: age, regno: regno, image: image);

      await addStudent(student);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const Register()));
      nameController.text = '';
      agecontroller.text = '';
      regnoController.text = '';
    }
  }

//ImageSource source as parameter
}
