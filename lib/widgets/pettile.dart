import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pawsome/helpers/constants.dart';

class PetTile extends StatelessWidget {
  final String image;
  final String name;
  final int id;
  // final int age;
  // final int price;
  final bool alreadyAdopted;
  final VoidCallback onTap;

  const PetTile(
      {super.key,
      required this.image,
      required this.name,
      required this.id,
      // required this.age,
      // required this.price,
      required this.onTap,
      required this.alreadyAdopted});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.max,
      children: [
        Material(
          child: InkWell(
            onTap: onTap,
            child: Card(
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.all(kPadding / 2),
                      child: Stack(
                        children: [
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                image,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white54,
                              child: IconButton(
                                  tooltip: "Bookmark",
                                  icon: const Icon(
                                    Icons.bookmark,
                                  ),
                                  onPressed: () {}),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: kPadding / 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: kPadding,
                      ),
                      Text(
                        name,
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      Text(alreadyAdopted ? "Already Adopted" : ""),
                      SizedBox(
                        width: kPadding + 10,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: kPadding,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: kPadding / 2,
        )
      ],
    );
  }
}
