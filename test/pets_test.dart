
import 'package:flutter_test/flutter_test.dart';

import 'package:pawsome/models/pet_model.dart';
import 'package:pawsome/providers/pets_provider.dart';


void main() {
  group("Pets test ", () {
    test("Pets list test", () {
      var result = HomeProvider().pets;
      // Assert
      expect(result, isEmpty);
    });
    // pet model test

    test("Model data test", () {
      Pet pet = Pet(
          adoptionTime: "2023",
          age: 12,
          id: 1,
          alreadyAdopted: false,
          image: "",
          liked: true,
          name: "",
          price: 2000);

      var id = pet.id;
      expect(id, 1);
    });

    test("get all pets test", ()async {
      
   


    });
  });
}
