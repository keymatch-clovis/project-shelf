class City {
  int id;
  String name;
  String department;

  City({
    required this.id,
    required this.name,
    required this.department,
  });

  factory City.fromMap(Map<String, Object?> map) {
    return City(
      id: int.parse(map["id"].toString()),
      name: map["name"].toString(),
      department: map["department"].toString(),
    );
  }
}
