import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> students = [
    {
      "id": 1,
      "name": "Alice Johnson",
      "email": "alice@example.com",
      "status": "Enrolled",
      "photo": "assets/images/enrolled_1.png",
    },
    {
      "id": 2,
      "name": "Bob Smith",
      "email": "bob@example.com",
      "status": "Graduated",
      "photo": "assets/images/graduated_1.png",
    },
    {
      "id": 3,
      "name": "Charlie Brown",
      "email": "charlie@example.com",
      "status": "Enrolled",
      "photo": "assets/images/enrolled_2.png",
    },
    // Add more students as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Management"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(student['photo']),
              ),
              title: Text(student['name']),
              subtitle: Text(student['email']),
              trailing: Text(
                student['status'],
                style: TextStyle(
                  color: student['status'] == 'Enrolled'
                      ? Colors.green
                      : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentDetailPage(student: student),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class StudentDetailPage extends StatelessWidget {
  final Map<String, dynamic> student;

  const StudentDetailPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(student['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(student['photo']),
              radius: 50,
            ),
            const SizedBox(height: 16),
            Text(
              'Name: ${student['name']}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Email: ${student['email']}'),
            const SizedBox(height: 8),
            Text('Status: ${student['status']}'),
          ],
        ),
      ),
    );
  }
}
