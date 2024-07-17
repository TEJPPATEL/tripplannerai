class City {
  final String id;
  final String name;
  final String state;

  City({required this.id, required this.name, required this.state});

  factory City.fromJSON(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJSON(City city) {
    return {'id': city.id, 'name': city.name, 'state': city.state};
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'state': state};
  }
}
