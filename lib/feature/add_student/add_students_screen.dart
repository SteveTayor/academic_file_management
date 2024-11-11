import 'package:flutter/material.dart';

class AddStudentPage extends StatelessWidget {
  const AddStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Add Student Page',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
