import 'package:pawsome/db/pets_database.dart';
import 'package:pawsome/models/pet_model.dart';

Future<List<Pet>> getPets({required int page}) async {
  var response = await PetsDataBase.instance.getAllPets();

  List<Pet> result = response.map<Pet>((json) => Pet.fromJson(json)).toList();

// This is to mimic pagination from sqflite database

  if (page == 1) {
    return result.sublist(0, 10);
  } else if (page == 2) {
    return result.sublist(10, 20);
  } else {
    return result.sublist(20);
  }
}
