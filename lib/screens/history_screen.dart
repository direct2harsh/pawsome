import 'package:flutter/material.dart';
import 'package:pawsome/db/initialise_database.dart';

import 'package:pawsome/db/pets_database.dart';
import 'package:pawsome/helpers/constants.dart';
import 'package:pawsome/main.dart';
import 'package:pawsome/models/pet_model.dart';
import 'package:pawsome/providers/history_provider.dart';
import 'package:pawsome/services/getAdoptedHistory.service.dart';
import 'package:pawsome/utilities/getDateTime.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryProvider>().callHistoryApi();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (context, data, child) {
        return Scaffold(
          body: data.historyloading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding / 2),
                  child: ListView.builder(
                      itemCount: data.pets.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            style: ListTileStyle.drawer,
                            leading: ClipOval(
                              child: Image.asset(
                                data.pets[index].image!,
                                cacheHeight: 200,
                                cacheWidth: 250,
                              ),
                            ),
                            trailing:
                                Text("\u{20B9}${data.pets[index].price!}"),
                            title: Text(data.pets[index].name!),
                            subtitle: Text(getDateFormated(
                                data.pets[index].adoptionTime!)),
                          ),
                        );
                      }),
                ),
        );
      },
    );
  }
}

// class HistoryScreen extends StatefulWidget {
//   const HistoryScreen({super.key});

//   @override
//   State<HistoryScreen> createState() => _HistoryScreenState();
// }

// class _HistoryScreenState extends State<HistoryScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
