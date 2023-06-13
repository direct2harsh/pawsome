import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PetDetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final int id;
  final int age;
  final int price;
  final bool alreadyAdopted;

  const PetDetailScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.id,
      required this.age,
      required this.price,
      required this.alreadyAdopted});

  @override
  State<PetDetailScreen> createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
          tag: widget.name,
          // This is fixing the renderoverlow [GitHub]
          flightShuttleBuilder: (
            BuildContext flightContext,
            Animation<double> animation,
            HeroFlightDirection flightDirection,
            BuildContext fromHeroContext,
            BuildContext toHeroContext,
          ) {
            return SingleChildScrollView(
              child: fromHeroContext.widget,
            );
          },
          child: Image.asset(widget.image)),
    );
  }
}
