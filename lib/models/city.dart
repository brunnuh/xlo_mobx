class City {
  int id;
  String name;

  City({this.id, this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['nome'],
    );
  }

  @override
  String toString() {
    return 'City{id: $id, name: $name}';
  }
}
