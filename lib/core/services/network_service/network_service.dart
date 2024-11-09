import 'dart:convert';
import 'package:http/http.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/course_model.dart';
import '../../models/student_model.dart';
import '../../utils/storage_key.dart';
import '../http_service/https_service.dart';

class NetworkService {
  final httpService = HttpService();
  static const baseUrl = "http://localhost:3000/data"; // Use your base URL
  final box = GetStorage();

  // Default header for API requests
  Map<String, String> get defaultHeader {
    return {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
  }

  // Auth header with token from storage
  Map<String, String> get postAuthHeader {
    String? accessToken = box.read(StorageKey.token);
    Map<String, String> authHeaders = {};
    authHeaders.addAll(defaultHeader);

    // Optionally add the Authorization header if token exists
    // if (accessToken != null) {
    //   authHeaders['Authorization'] = 'Bearer $accessToken';
    // }

    return authHeaders;
  }

  // Future<AuthResponse?> login(
  //     {required String username, required String password}) async {
  //   var url = "${baseUrl}/api/user/login";

  //   Map<String, dynamic> payload = {
  //     "username": username,
  //     "password": password,
  //   };

  //   Response response = await httpService.post(
  //     Uri.parse(url),
  //     body: jsonEncode(payload),
  //     headers: defaultHeader,
  //   );

  //   return authResponseFromJson(response.body);
  // }

  // Fetch All Students
  Future<List<StudentModel>> getAllStudents() async {
    var url = '$baseUrl/students';

    Response response = await httpService.get(
      Uri.parse(url),
      headers: postAuthHeader,
    );

    // Deserialize the response to a list of students
    List<dynamic> studentsJson = jsonDecode(response.body);
    return studentsJson
        .map((student) => StudentModel.fromJson(student))
        .toList();
  }

  // Fetch Student Details
  Future<StudentModel?> getStudentDetails(int studentId) async {
    var url = '$baseUrl/students/$studentId';

    Response response = await httpService.get(
      Uri.parse(url),
      headers: postAuthHeader,
    );

    if (response.statusCode == 200) {
      return StudentModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  // Add New Student
  Future<StudentModel?> addStudent(
      {required String name,
      required String email,
      required String status,
      required String photo}) async {
    var url = '$baseUrl/students';

    Map<String, dynamic> payload = {
      "name": name,
      "email": email,
      "status": status,
      "photo": photo,
    };

    Response response = await httpService.post(
      Uri.parse(url),
      body: jsonEncode(payload),
      headers: postAuthHeader,
    );

    return StudentModel.fromJson(jsonDecode(response.body));
  }

  // Update Student Information
  Future<StudentModel?> updateStudent(int studentId,
      {required String name,
      required String email,
      required String status,
      required String photo}) async {
    var url = '$baseUrl/students/$studentId';

    Map<String, dynamic> payload = {
      "name": name,
      "email": email,
      "status": status,
      "photo": photo
    };

    Response response = await httpService.put(
      Uri.parse(url),
      body: jsonEncode(payload),
      headers: postAuthHeader,
    );

    return StudentModel.fromJson(jsonDecode(response.body));
  }

  // Fetch All Courses
  Future<List<CourseModel>> getAllCourses() async {
    var url = '$baseUrl/courses';

    Response response = await httpService.get(
      Uri.parse(url),
      headers: postAuthHeader,
    );

    List<dynamic> coursesJson = jsonDecode(response.body);
    return coursesJson.map((course) => CourseModel.fromJson(course)).toList();
  }

  // Enroll Student in a Course
  Future<void> enrollStudentInCourse(int studentId, int courseId) async {
    var url = '$baseUrl/students/$studentId/enroll';

    Map<String, dynamic> payload = {
      "course_id": courseId,
    };

    await httpService.post(
      Uri.parse(url),
      body: jsonEncode(payload),
      headers: postAuthHeader,
    );
  }
}
