import 'course_model.dart';

class StudentModel {
  int id;
  String name;
  String email;
  String status;
  String photo;
  List<CourseModel> courses;

  StudentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.photo,
    required this.courses,
  });

  // Factory method to create StudentModel object from JSON
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    var courseList = (json['courses'] as List)
        .map((courseJson) => CourseModel.fromJson(courseJson))
        .toList();

    return StudentModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      status: json['status'],
      photo: json['photo'],
      courses: courseList,
    );
  }

  // Method to convert StudentModel object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'status': status,
      'photo': photo,
      'courses': courses.map((course) => course.toJson()).toList(),
    };
  }
}
