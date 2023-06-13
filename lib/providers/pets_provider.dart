import 'package:flutter/material.dart';
import 'package:pawsome/models/pet_model.dart';
import 'package:pawsome/services/getPetslist.service.dart';

enum PetState { loaded, uninitialized, loadingMore, refreshing, empty, error }

class PetProvider extends ChangeNotifier {
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

  Future<void> callPetApi() async {
    // Handling end of data
    if (_page > 3) {
      return;
    }
    petState = PetState.loadingMore;
    notifyListeners();
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        List<Pet> res = await getPets(page: _page);
        _pets.addAll(res);
        page = page + 1;
        petState = PetState.loaded;
        notifyListeners();
      },
    );
  }
}
