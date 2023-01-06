import 'dog_datasource.dart';
import 'dog_model.dart';

class DogRepository {
  final _dogDataSource = DogDataSource();

  Future<void> insertDog(Dog dog) async {
    await _dogDataSource.insertDog(dog);
  }

  Future<List<Dog>> readDogs() async {
    return await _dogDataSource.readDogs();
  }

  Future<void> updateDog(Dog dog) async {
    await _dogDataSource.updateDog(dog);
  }

  Future<void> deleteDog(int id) async {
    await _dogDataSource.deleteDog(id);
  }

  Future<void> closeDatabase() async {
    await _dogDataSource.closeDatabase();
  }
}
