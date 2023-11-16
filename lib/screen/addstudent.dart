import 'dart:io';
import 'package:app/database/db_functions.dart';
import 'package:app/database/db_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
                                                              

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  File? image25;
  String? imagepath;
  final _formKey = GlobalKey<FormState>(); // Add a form key for the validation

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _guardianController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 117, 238, 177),
        title: const Text('Add Student'),
        actions: [
          TextButton.icon(
            label: const Text('Save'),
            onPressed: () {
              addstudentclicked(context);
              
            },
            icon: const Icon(Icons.save_rounded),
          )
        ],
        centerTitle: true,
      ),
      backgroundColor: Colors.cyan.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey, // The form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                        backgroundImage: image25 != null
                            ? FileImage(image25!)
                            : null 
                                ,
                        radius: 100),
                    Positioned(
                      bottom: 20,
                      right: 5,
                      child: IconButton(
                        onPressed: () {
                          addphoto(context);
                        },
                        icon: const Icon(Icons.add_a_photo_outlined),
                        color: const Color.fromARGB(255, 255, 255, 255),
                        iconSize: 40,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // Name input field with validation
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: const Icon(Icons.abc_outlined),
                    suffixIconColor: Colors.purple,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Age input field with validation
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _ageController,
                  decoration: InputDecoration(
                    labelText: "Age",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: const Icon(Icons.perm_contact_cal_sharp),
                    suffixIconColor: Colors.purple,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Age';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Guardian input field with validation
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _guardianController,
                  decoration: InputDecoration(
                    labelText: "Guardian",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: const Icon(Icons.person),
                    suffixIconColor: Colors.purple,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Guardian';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Mobile input field with validation
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _mobileController,
                  decoration: InputDecoration(
                    labelText: "Mobile",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: const Icon(Icons.phone_sharp),
                    suffixIconColor: Colors.purple,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Mobile';
                    } else if (value.length != 10) {
                      return 'Mobile number should be 10 digits';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addstudentclicked(mtx) async {
    if (_formKey.currentState!.validate() && image25 != null) {
      final name = _nameController.text.toUpperCase();
      final age = _ageController.text.toString().trim();
      final father = _guardianController.text;
      final phonenumber = _mobileController.text.trim();

      final stdData = StudentModel(
        name: name,
        age: age,
        father: father,
        pnumber: phonenumber,
        imagex: imagepath!,
      );
      await addstudent(stdData); // Use the correct function name addStudent.

      ScaffoldMessenger.of(mtx).showSnackBar(
        const SnackBar(
          content: Text("Successfully added"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.greenAccent,
          duration: Duration(seconds: 2),
        ),
      );

      setState(() {
        image25 = null;
        _nameController.clear();
        _ageController.clear();
        _guardianController.clear();
        _mobileController.clear();
      });
      Navigator.of(mtx).pop();
    } else {
      ScaffoldMessenger.of(mtx).showSnackBar(
        const SnackBar(
          content: Text('Add all details'),
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  Future<void> getimage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }
    setState(() {
      image25 = File(image.path);
      imagepath = image.path.toString();
    });
  }

  void addphoto(ctxr) {
    showDialog(
      context: ctxr,
      builder: (ctxr) {
        return AlertDialog(
          content: const Text('Choose Image From.......'),
          actions: [
            IconButton(
              onPressed: () {
                getimage(ImageSource.camera);
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                getimage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.image,
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}