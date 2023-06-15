import 'package:flutter/material.dart';
import 'package:pawsome/db/pets_database.dart';
import 'package:pawsome/models/pet_model.dart';
import 'package:pawsome/services/getPetslist.service.dart';

enum PetState { loaded, uninitialized, loadingMore, refreshing, empty, error }

class HomeProvider extends ChangeNotifier {
  int _page = 1;
  int get page => _page;

  PetState petState = PetState.uninitialized;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  List<Pet> _pets = [];

  List<Pet> get pets => _pets;

  set pets(List<Pet> value) {
    _pets = value;
    notifyListeners();
  }

  // To keep the original list of pets
  List<Pet> mainPetsList = [];

  Future<void> callPetApi() async {
    // Handling end of data
    if (_page > 3) {
      return;
    }

    if (page > 1) {
      petState = PetState.loadingMore;
      notifyListeners();
    }

    Future.delayed(
      const Duration(seconds: 4),
      () async {
        List<Pet> temp = await getPets(page: _page);
        mainPetsList.addAll(temp);

        _pets.addAll(temp);
        page = page + 1;
        petState = PetState.loaded;
        notifyListeners();
      },
    );
  }

// Adopt Pet logic
  void adoptPet(int index) {
    _pets[index].alreadyAdopted = true;
    _pets[index].adoptionTime = DateTime.now().toLocal().toString();
// Updating it to database
    PetsDataBase.instance.update(_pets[index]);
    notifyListeners();
  }

  // Adopt Pet logic
  void likeUnlikePet(int index) {
    _pets[index].liked = !_pets[index].liked!;
    _pets[index].adoptionTime = DateTime.now().toLocal().toString();
// Updating it to database
    PetsDataBase.instance.update(_pets[index]);
    notifyListeners();
  }

// Search pet logic

  void searchPets(String query) {
    petState = PetState.refreshing;
    notifyListeners();
    _pets.clear();

    if (query.isEmpty) {
      // Adding original list of data from database.
      _pets.addAll(mainPetsList);
      petState = PetState.loaded;
      notifyListeners();
    } else {
      for (Pet pet in mainPetsList) {
        if (pet.name!.toLowerCase().contains(query)) {
          _pets.add(pet);
        }
      }
      petState = PetState.loaded;
      notifyListeners();
    }
  }
}
