class CourseModel {
  String courseCode;
  String courseTitle;
  String courseDescription;
  String courseInstructor;

  CourseModel({
    required this.courseCode,
    required this.courseTitle,
    required this.courseDescription,
    required this.courseInstructor,
  });

  // Factory method to create Course object from JSON
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      courseCode: json['course_code'],
      courseTitle: json['course_title'],
      courseDescription: json['course_description'],
      courseInstructor: json['course_instructor'],
    );
  }

  // Method to convert Course object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'course_code': courseCode,
      'course_title': courseTitle,
      'course_description': courseDescription,
      'course_instructor': courseInstructor,
    };
  }
}
