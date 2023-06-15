import 'package:flutter/material.dart';

import 'package:pawsome/helpers/constants.dart';

import 'package:pawsome/providers/history_provider.dart';

import 'package:pawsome/utilities/get_datetime.dart';
import 'package:pawsome/widgets/empty_history.dart';
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
    FocusScope.of(context).unfocus();
    return Consumer<HistoryProvider>(
      builder: (context, data, child) {
        if (data.state == HistoryState.loading ||
            data.state == HistoryState.uninitialized) {
          return const Center(
            child: CircularProgressIndicator(
              color: kGreenColor,
            ),
          );
        }
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding / 2),
            child: data.pets.isEmpty
                ? const EmptyHistoryWidget()
                : ListView.builder(
                    itemCount: data.pets.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          style: ListTileStyle.drawer,
                          leading: ClipOval(
                            child: Image.asset(
                              data.pets[index].image!,
                              cacheHeight: 500,
                              cacheWidth: 500,
                            ),
                          ),
                          trailing: Text("\u{20B9}${data.pets[index].price!}"),
                          title: Text(data.pets[index].name!),
                          subtitle: Text(
                              getDateFormated(data.pets[index].adoptionTime!)),
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
