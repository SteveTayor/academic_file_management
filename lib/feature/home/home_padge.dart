// lib/screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/students_provider.dart';
import 'widgets/home_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Management"),
      ),
      body: FutureBuilder(
        future: studentProvider.fetchStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading data"));
          } else {
            return StudentListWidget(students: studentProvider.students);
          }
        },
      ),
    );
  }
}
