import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_sqlflite/my_version_for_flutter_aplication/home_controller.dart';

import 'dog_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController homeController;
  late Dog fido;

  @override
  void initState() {
    super.initState();
    homeController = HomeController([]);
    homeController.readDogs();
  }

  @override
  void dispose() {
    homeController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Center(
                child: Text(
              'List of Dogs',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            )),
            const SizedBox(height: 20),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: homeController,
                builder: (context, value, child) {
                  return ListView.separated(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text('ID: ${value[index].id}'),
                          title: Text('Name: ${value[index].name}'),
                          trailing: Text('Age: ${value[index].age}'),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                            height: 4,
                            color: Colors.black,
                          ));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => homeController.insertDog(Dog(
                          id: Random().nextInt(100),
                          name: 'Fido',
                          age: Random().nextInt(20) + 1)),
                      child: const Text('Insert Dog'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => homeController.updateDog(Dog(
                          id: homeController
                              .value[
                                  Random().nextInt(homeController.value.length)]
                              .id,
                          name: 'Fido 2',
                          age: Random().nextInt(20) + 1)),
                      child: const Text('Update Dog'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: (() => homeController
                            .deleteDog(homeController.value.last.id)),
                        child: const Text('Delete Dog')),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
