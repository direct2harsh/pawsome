import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class EmptyPetsWidget extends StatelessWidget {
  const EmptyPetsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            "No matches",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
