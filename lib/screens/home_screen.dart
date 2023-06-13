import 'package:flutter/material.dart';
import 'package:pawsome/db/initialise_database.dart';

import 'package:pawsome/db/pets_database.dart';
import 'package:pawsome/helpers/constants.dart';
import 'package:pawsome/providers/pets_provider.dart';
import 'package:pawsome/screens/pet_detail_screen.dart';
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    filled: true,
                    // fillColor: const Color.fromARGB(255, 204, 253, 206),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue)),
                    hintText: "Search",
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.search)
                    // hintStyle:
                    //     TextStyle(fontSize: 20, color: Colors.black, height: 2.6),
                    // prefixIcon: IconButton(
                    //   color: kswisDarkColor,
                    //   onPressed: () async {
                    //     bool isProd =
                    //         await StorageUtil.getBool("isProduction") ?? false;
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => AllSettings(
                    //                   isProd: isProd,
                    //                 )));
                    //   },
                    //   icon: Icon(
                    //     Icons.menu,
                    //     size: kIconLarge,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    ),
              ),
              const SizedBox(
                height: kPadding,
              ),
              Flexible(
                child: Stack(
                  // fit: StackFit.expand,
                  children: [
                    ListView.builder(
                        controller: _scrollController,
                        // physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,

                        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 1),
                        itemCount: provider.pets.length,
                        addAutomaticKeepAlives: true,
                        itemBuilder: (context, index) {
                          return Hero(
                            tag: provider.pets[index].name!,
                            child: PetTile(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PetDetailScreen(
                                            // Insted of passing all the values other way would be to fetch the details from db based on id.
                                            // Since all the details are already available using this method
                                            image: provider.pets[index].image!,
                                            id: provider.pets[index].id!,
                                            age: provider.pets[index].age!,
                                            alreadyAdopted: provider
                                                .pets[index].alreadyAdopted!,
                                            name: provider.pets[index].name!,
                                            price: provider.pets[index].price!,
                                          ))),
                              image: provider.pets[index].image!,
                              id: provider.pets[index].id!,
                              // age: provider.pets[index].age!,
                              alreadyAdopted:
                                  provider.pets[index].alreadyAdopted!,
                              name: provider.pets[index].name!,
                              // price: provider.pets[index].price!,
                            ),
                          );
                        }),
                    Visibility(
                        visible: provider.petState == PetState.loadingMore,
                        child: const Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: kPadding),
                              child: CircularProgressIndicator(),
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
