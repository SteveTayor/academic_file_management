// lib/widgets/student_list_widget.dart
import 'package:flutter/material.dart';
import '../../../core/models/student_model.dart';
import '../../student_detail/student_details_screen.dart';

class StudentListWidget extends StatelessWidget {
  final List<StudentModel> students;

  const StudentListWidget({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(student.photo),
            ),
            title: Text(student.name),
            subtitle: Text(student.email),
            trailing: Text(
              student.status,
              style: TextStyle(
                color:
                    student.status == 'Enrolled' ? Colors.green : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      StudentDetailPage(student: student.toJson()),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
