import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:pawsome/models/pet_model.dart';
import 'package:pawsome/services/getAdoptedHistory.service.dart';

enum HistoryState { uninitialized, loading, loaded }

class HistoryProvider extends ChangeNotifier {
  HistoryState state = HistoryState.uninitialized;

  List<Pet> _pets = [];

  List<Pet> get pets => _pets;

  set pets(List<Pet> value) {
    _pets = value;
    notifyListeners();
  }

  Future<void> callHistoryApi() async {
    state = HistoryState.loading;
    // notifyListeners();
    _pets.clear();

    Future.delayed(
      const Duration(seconds: 3),
      () async {
        List<Pet> res = await getAdoptedPetList();
        _pets.addAll(res);
        state = HistoryState.loaded;
        notifyListeners();
      },
    );
  }
}
