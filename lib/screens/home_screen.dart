import 'package:flutter/material.dart';
import 'package:pawsome/db/initialise_database.dart';

import 'package:pawsome/db/pets_database.dart';
import 'package:pawsome/helpers/constants.dart';
import 'package:pawsome/providers/pets_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Get more data at end of page
        context.read<PetProvider>().callPetApi();
      }
    });
    // initial data
    context.read<PetProvider>().callPetApi();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PetProvider>(
      builder: (context, provider, child) {
        if (provider.petState == PetState.uninitialized) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Stack(
          children: [
            Visibility(
                visible: provider.petState == PetState.loadingMore,
                child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: kPadding),
                      child: CircularProgressIndicator(),
                    ))),
            Padding(
              padding: const EdgeInsets.all(kPadding),
              child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1),
                  itemCount: provider.pets.length,
                  itemBuilder: (context, index) {
                    return GridTile(
                        child: Image.asset(provider.pets[index].image!));
                  }),
            ),
          ],
        );
      },
    );
  }
}
