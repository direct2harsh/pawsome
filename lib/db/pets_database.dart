import 'package:flutter/material.dart';
import 'package:pawsome/models/pet_model.dart';
import 'package:sqflite/sqflite.dart';

class PetsDataBase {
  static final PetsDataBase instance = PetsDataBase._init();
  static Database? _database;
  PetsDataBase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB('pets.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEN NOT NULL';
    const intType = 'INTEGET NOT NULL';
    const dateType = 'TEXT';

    await db.execute('''
CREATE TABLE $petTable(
${PetsField.id} $idType,
${PetsField.name} $textType,
${PetsField.age} $intType,
${PetsField.price} $intType,
${PetsField.image} $textType,
${PetsField.alreadyAdopted} $boolType,
${PetsField.liked} $boolType,
${PetsField.adoptionTime} $dateType
)''');
  }

  void addPet(Pet pet) async {
    final db = await instance.database;
    await db?.insert(petTable, pet.toJson());
  }

  void addMultiplePet(List<Pet> pets) async {
    final db = await instance.database;
    for (Pet value in pets) {
      try {
        await db?.insert(petTable, value.toJson());
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<dynamic> getAllPets() async {
    final db = await instance.database;
    final result = await db!.query(petTable);

    return result;
  }

  void update(Pet pet) async {
    final db = await instance.database;
    db!.update(petTable, pet.toJson(),
        where: '${PetsField.id}=?', whereArgs: [pet.id]);
  }

  void close() async {
    final db = await instance.database;

    db?.close();
  }
}
