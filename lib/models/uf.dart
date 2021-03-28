class UF {
  int id;
  String initials;
  String name;

  factory UF.fromJson(Map<String, dynamic> json) {
    return UF(
      id: json['id'],
      initials: json['sigla'],
      name: json['nome'],
    );
  }

  UF({this.id, this.initials, this.name});

  @override
  String toString() {
    return 'UF{id: $id, initials: $initials, name: $name}';
  }
}
