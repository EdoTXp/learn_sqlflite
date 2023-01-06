import 'package:flutter/material.dart';
import 'package:learn_sqlflite/my_version_for_flutter_aplication/dog_repository.dart';

import 'dog_model.dart';

class HomeController extends ValueNotifier<List<Dog>> {
  HomeController(super.value);
  final dogRepository = DogRepository();

  Future<void> readDogs() async {
    value = await dogRepository.readDogs();
  }

  Future<void> insertDog(Dog dog) async {
    await dogRepository.insertDog(dog);
    readDogs();
  }

  Future<void> updateDog(Dog dog) async {
    if (value.isNotEmpty) {
      await dogRepository.updateDog(dog);
    }
    readDogs();
  }

  Future<void> deleteDog(int id) async {
    if (value.isNotEmpty) {
      await dogRepository.deleteDog(id);
    }
    readDogs();
  }

  Future<void> close() async {
    await dogRepository.closeDatabase();
  }
}
