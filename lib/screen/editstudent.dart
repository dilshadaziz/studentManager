import 'dart:io';
import 'package:app/database/db_functions.dart';
import 'package:app/database/db_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class EditStudent extends StatefulWidget {
  final student;

  const EditStudent({super.key, required this.student});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  String? updatedImagepath;

  final _formKey = GlobalKey<FormState>(); //  form key for the validation

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _guardianController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 186, 246, 240),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 197, 169, 248),
        title: const Text('Edit Student'),
        actions: [
          TextButton.icon(
            label: Text('Update'),
            onPressed: () {
              editstudentclicked(
                context,
                widget.student,
              );
            },
            icon: const Icon(Icons.cloud_upload),
          )
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey, // Assign the form key
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      InkWell(
                        
                        onTap: () => editphoto(context),
                        child: CircleAvatar(
                          backgroundImage: updatedImagepath != null
                              ? FileImage(File(updatedImagepath!))
                              : FileImage(File(widget.student.imagex)),
                          radius: 80,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),

                  // Name input field with validation
                  Row(
                    children: [
                      const Icon(Icons.abc_outlined),
                      const SizedBox(
                          width: 10), // Add spacing between icon and text field
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: "Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Age input field with validation
                  Row(
                    children: [
                      const Icon(Icons.perm_contact_cal),
                      const SizedBox(
                          width: 10), // Add spacing between icon and text field
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _ageController,
                          decoration: InputDecoration(
                            labelText: "Class",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Age';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Guardian input field with validation
                  Row(
                    children: [
                      const Icon(Icons.person),
                      const SizedBox(
                          width: 10), // Add spacing between icon and text field
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _guardianController,
                          decoration: InputDecoration(
                            labelText: "Parent",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Parent Name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Mobile input field with validation
                  Row(
                    children: [
                      const Icon(Icons.phone_sharp),
                      const SizedBox(
                          width: 10), // Add spacing between icon and text field
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _mobileController,
                          decoration: InputDecoration(
                            labelText: "Mobile number",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a mobile number';
                            } else if (value.length != 10) {
                              return 'Mobile number should be 10 digits';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.student.name;
    _ageController.text = widget.student.age;
    _guardianController.text = widget.student.father;
    _mobileController.text = widget.student.pnumber;
    updatedImagepath = widget.student.imagex;
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Future<void> geterimage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }
    setState(() {
      updatedImagepath = image.path.toString();
    });
  }

  Future<void> editstudentclicked(
      BuildContext context, StudentModel student) async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.toUpperCase();
      final age = _ageController.text.toString().trim();
      final father = _guardianController.text;
      final phonenumber = _mobileController.text.trim();

      final updatedStudent = StudentModel(
        id: student.id,
        name: name,
        age: age,
        father: father,
        pnumber: phonenumber,
        imagex: updatedImagepath ?? student.imagex,
      );

      await editStudent(
        student.id!,
        updatedStudent.name,
        updatedStudent.age,
        updatedStudent.father,
        updatedStudent.pnumber,
        updatedStudent.imagex,
      );

      // Refresh the data in the StudentList widget.
      getstudentdata();

      Navigator.of(context).pop();
    }
  }

  void editphoto(ctxr) {
    showDialog(
      context: ctxr,
      builder: (ctxr) {
        return AlertDialog(
          title: const Text('Update Photo '),
          actions: [
            Column(
              children: [
                Row(
                  children: [
                    const Text('Choose from camera'),
                    IconButton(
                      onPressed: () {
                        geterimage(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.camera_alt_rounded,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Choose from gallery '),
                    IconButton(
                      onPressed: () {
                        geterimage(ImageSource.gallery);
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.image,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}