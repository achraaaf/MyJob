import 'package:MyJob/employer_screens/Controller/EmployerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class E_Home extends StatefulWidget {
  const E_Home({super.key});

  @override
  State<E_Home> createState() => _E_HomeState();
}

class _E_HomeState extends State<E_Home> {
  late final EmployerController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(EmployerController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          child: Column(
            children: [],
          ),
        ),
      )),
    );
  }
}
