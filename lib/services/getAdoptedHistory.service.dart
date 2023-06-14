import 'package:pawsome/db/pets_database.dart';
import 'package:pawsome/models/pet_model.dart';

Future<List<Pet>> getAdoptedPetList() async {
  var response = await PetsDataBase.instance.getAllPets();
  List<Pet> result = response.map<Pet>((json) => Pet.fromJson(json)).toList();
  // Removing not adopted pets
  result.removeWhere((element) => element.alreadyAdopted == false);
  result.sort((a, b) {
    return a.adoptionTime!.compareTo(b.adoptionTime!);
  });
  return result;
}
