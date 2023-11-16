import 'dart:io';
import 'package:flutter/material.dart';

class StudentDetails extends StatelessWidget {
  final stdetails;
  const StudentDetails({super.key, required this.stdetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          height: 400,
          width: 400,
          child: SizedBox(
           
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(stdetails.imagex),
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name :  ${stdetails.name}',
                        style: const TextStyle(fontSize: 23)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Age :  ${stdetails.age}',
                        style: const TextStyle(fontSize: 23)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Parent :  ${stdetails.father}',
                        style: const TextStyle(fontSize: 23)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Mobile : +91 ${stdetails.pnumber}',
                        style: const TextStyle(fontSize: 23)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}