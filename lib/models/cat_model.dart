class Cat {
  //int id
  final int? id;
  final String race;
  final String name;
  final String imagepath;

//no importa el orden en el que se pasen los parametros
  //required this.id, ver como le puedo quitar el id
  Cat(
      {this.id,
      required this.race,
      required this.name,
      required this.imagepath});

  factory Cat.fromMap(Map<String, dynamic> json) => Cat(
      id: json['id'],
      race: json['race'],
      name: json['name'],
      imagepath: json['imagepath']);

  Map<String, dynamic> toMap() {
    return {'id': id, 'race': race, 'name': name, 'imagepath': imagepath};
  }
}
