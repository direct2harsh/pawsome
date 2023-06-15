import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class EmptyHistoryWidget extends StatelessWidget {
  const EmptyHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.pets,
            color: Colors.blueGrey,
            size: 70,
          ),
          SizedBox(
            height: kPadding / 2,
          ),
          Text(
            "No History",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: kGreenColor),
          ),
        ],
      ),
    );
  }
}
