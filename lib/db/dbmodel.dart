class StudentModel {
  final String name;
  final String age;
  final String regno;
  String image;
  final int? id;

  StudentModel(
      {required this.name,
      required this.age,
      required this.regno,
      required this.image,
      this.id});

  static StudentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    final age = map['age'] as String;
    final regno = map['regnum'] as String;
    final image = map['image'] as String;

    return StudentModel(
        id: id, name: name, age: age, regno: regno, image: image);
  }
}
