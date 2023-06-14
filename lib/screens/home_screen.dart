import 'package:flutter/material.dart';
import 'package:pawsome/db/initialise_database.dart';

import 'package:pawsome/db/pets_database.dart';
import 'package:pawsome/helpers/constants.dart';
import 'package:pawsome/providers/pets_provider.dart';
import 'package:pawsome/screens/pet_detail_screen.dart';
import 'package:pawsome/widgets/empty_pets.dart';
import 'package:pawsome/widgets/pettile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // To disable the focus from the SearchField
      FocusScope.of(context).unfocus();
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
            child: CircularProgressIndicator(
              color: kColor,
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            children: [
              TextField(
                autofocus: false,
                decoration: InputDecoration(
                    filled: true,
                    // fillColor: const Color.fromARGB(255, 204, 253, 206),
                    border: OutlineInputBorder(
                        // borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(15)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: kColor)),
                    hintText: "Search",
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.search)),
                onChanged: (value) {
                  provider.searchPets(value.toLowerCase());
                },
              ),
              const SizedBox(
                height: kPadding,
              ),
              Flexible(
                child: Stack(
                  // fit: StackFit.expand,
                  children: [
                    provider.pets.isEmpty
                        ? const EmptyPetsWidget()
                        : ListView.builder(
                            controller: _scrollController,
                            // physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,

                            // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            //     crossAxisCount: ),
                            itemCount: provider.pets.length,
                            addAutomaticKeepAlives: true,
                            itemBuilder: (context, index) {
                              // // To disable the focus form the Search TextField
                              // FocusScope.of(context).unfocus();
                              return Hero(
                                tag: provider.pets[index].name!,
                                child: Opacity(
                                  opacity: provider.pets[index].alreadyAdopted!
                                      ? .4
                                      : 1,
                                  child: PetTile(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PetDetailScreen(
                                                  // Insted of passing all the values other way would be to fetch the details from db based on id.
                                                  // Since all the details are already available using this method
                                                  // image: provider.pets[index].image!,
                                                  // id: provider.pets[index].id!,
                                                  // age: provider.pets[index].age!,
                                                  // alreadyAdopted: provider
                                                  //     .pets[index].alreadyAdopted!,
                                                  name: provider
                                                      .pets[index].name!,
                                                  // price: provider.pets[index].price!,
                                                  index: index,
                                                ))),
                                    image: provider.pets[index].image!,
                                    id: provider.pets[index].id!,
                                    // age: provider.pets[index].age!,
                                    alreadyAdopted:
                                        provider.pets[index].alreadyAdopted!,
                                    name: provider.pets[index].name!,
                                    // price: provider.pets[index].price!,
                                  ),
                                ),
                              );
                            }),
                    Visibility(
                        visible: provider.petState == PetState.loadingMore,
                        child: const Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: kPadding),
                              child: CircularProgressIndicator(
                                color: kColor,
                              ),
                            ))),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
