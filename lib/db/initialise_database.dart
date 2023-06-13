import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pawsome/db/pets_database.dart';
import 'package:pawsome/models/pet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This funtion is adding the The json data form asset/json_data to sqllite database for persistence only once

void initialiseDataBase() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool alreadyInitialised = prefs.getBool('alreadyInitialised') ?? false;

// Only adding to once

  if (!alreadyInitialised) {
    var data = await rootBundle.loadString('assets/json_data.txt');
    List decodedData = jsonDecode(data.trim());
    List<Pet> pets = decodedData
        .map((json) => Pet(
            id: json['id'],
            name: json['name'],
            age: json['age'],
            image: json['image'],
            price: json['price'],
            alreadyAdopted: json['alreadyAdopted']))
        .toList();

    PetsDataBase.instance.addMultiplePet(pets);

    await prefs.setBool('alreadyInitialised', true);
  }
}
