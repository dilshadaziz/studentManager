class StudentModel {
  int? id;
  final String name;
  final String age;
  final String father;
  final String pnumber;
  final String imagex;

  StudentModel(
      {this.id,
      required this.name,
      required this.age,
      required this.father,
      required this.pnumber,
      required this.imagex});

  static StudentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    final age = map['age'] as String;
    final father = map['father'] as String;
    final pnumber = map['pnumber'] as String;
    final imagex = map['imagex'] as String;
    return StudentModel(
        id: id,
        name: name,
        age: age,
        father: father,
        pnumber: pnumber,
        imagex: imagex);
  }
}