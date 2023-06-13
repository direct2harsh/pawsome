const String petTable = "pets";

class PetsField {
  static const String id = "_id";
  static const String name = "name";
  static const String age = "age";
  static const String price = "price";
  static const String image = "image";
  static const String alreadyAdopted = "alreadyAdopted";
}

class Pet {
  int? id;
  String? name;
  int? age;
  int? price;
  String? image;
  bool? alreadyAdopted;

  Pet(
      {this.name,
      this.age,
      this.price,
      this.image,
      this.alreadyAdopted,
      this.id});

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
      id: json['_id'],
      name: json['name'],
      age: json['age'],
      price: json['price'],
      alreadyAdopted: json['alreadyAdopted'] == 1 ? true : false,
      image: json['image']);

  Map<String, dynamic> toJson() => {
        PetsField.id: id,
        PetsField.name: name,
        PetsField.age: age,
        PetsField.price: price,
        PetsField.image: image,
        PetsField.alreadyAdopted: alreadyAdopted! ? 1 : 0,
      };
}
