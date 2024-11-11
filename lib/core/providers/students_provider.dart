import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../models/course_model.dart';
import '../services/network_service/network_service.dart';

class StudentProvider extends ChangeNotifier {
  final NetworkService _networkService = NetworkService();

  // State variables for students and courses
  List<StudentModel> _students = [];
  List<CourseModel> _courses = [];
  bool _isLoading = false;

  // Getters for students, courses, and loading state
  List<StudentModel> get students => _students;
  List<CourseModel> get courses => _courses;
  bool get isLoading => _isLoading;

  // Fetch all students
  Future<void> fetchStudents() async {
    _setLoading(true);
    try {
      _students = await _networkService.getAllStudents();
    } catch (e) {
      // Handle errors (e.g., log or show a message)
      print("Error fetching students: $e");
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  // Fetch student details
  Future<StudentModel?> fetchStudentDetails(int studentId) async {
    try {
      return await _networkService.getStudentDetails(studentId);
    } catch (e) {
      print("Error fetching student details: $e");
      return null;
    }
  }

  // Add a new student
  Future<void> addStudent({
    required String name,
    required String email,
    required String status,
    required String photo,
  }) async {
    _setLoading(true);
    try {
      StudentModel? newStudent = await _networkService.addStudent(
        name: name,
        email: email,
        status: status,
        photo: photo,
      );
      if (newStudent != null) {
        _students.add(newStudent);
        notifyListeners();
      }
    } catch (e) {
      print("Error adding student: $e");
    } finally {
      _setLoading(false);
    }
  }

  // Update student information
  Future<void> updateStudent(
    int studentId, {
    required String name,
    required String email,
    required String status,
    required String photo,
  }) async {
    _setLoading(true);
    try {
      StudentModel? updatedStudent = await _networkService.updateStudent(
        studentId,
        name: name,
        email: email,
        status: status,
        photo: photo,
      );
      if (updatedStudent != null) {
        int index = _students.indexWhere((student) => student.id == studentId);
        if (index != -1) {
          _students[index] = updatedStudent;
          notifyListeners();
        }
      }
    } catch (e) {
      print("Error updating student: $e");
    } finally {
      _setLoading(false);
    }
  }

  // Fetch all courses
  Future<void> fetchCourses() async {
    _setLoading(true);
    try {
      _courses = await _networkService.getAllCourses();
      notifyListeners();
    } catch (e) {
      print("Error fetching courses: $e");
    } finally {
      _setLoading(false);
    }
  }

  // Enroll student in a course
  Future<void> enrollStudentInCourse(int studentId, int courseId) async {
    try {
      await _networkService.enrollStudentInCourse(studentId, courseId);
      // Optionally, you could refresh the student's data here if needed
    } catch (e) {
      print("Error enrolling student in course: $e");
    }
  }

  // Set loading state and notify listeners
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
