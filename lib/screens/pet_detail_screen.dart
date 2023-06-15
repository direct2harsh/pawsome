import 'package:flutter/material.dart';

import 'package:pawsome/helpers/constants.dart';
import 'package:pawsome/main.dart';
import 'package:pawsome/providers/pets_provider.dart';
import 'package:pawsome/screens/image_view.dart';
import 'package:pawsome/widgets/adopted_alertbox.dart';
import 'package:provider/provider.dart';

class PetDetailScreen extends StatefulWidget {
  // final String image;
  final String name;
  // final int id;
  // final int age;
  // final int price;
  // final bool alreadyAdopted;
  final int index;

  const PetDetailScreen({
    super.key,
    // required this.image,
    required this.name,
    // required this.id,
    // required this.age,
    // required this.price,
    required this.index,
    // required this.alreadyAdopted
  });

  @override
  State<PetDetailScreen> createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDark = MyApp.of(context).themeMode == ThemeMode.dark;
    return SafeArea(
      child: Consumer<HomeProvider>(builder: (context, data, child) {
        return Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(
                bottom: kPadding, left: kPadding, right: kPadding),
            child: SizedBox(
                height: 50,
                child: Tooltip(
                  message: "Adopt me",
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kGreenColor,
                        elevation: 25,
                        // shape: StadiumBorder(),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        enableFeedback: true,
                      ),
                      onPressed: !data.pets[widget.index].alreadyAdopted!
                          ? () {
                              data.adoptPet(widget.index);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AdoptedAlertBox(
                                        name: data.pets[widget.index].name!);
                                  });
                            }
                          : null,
                      child: Text(data.pets[widget.index].alreadyAdopted!
                          ? "Already Adopted"
                          : "Adopt me")),
                )),
          ),
          body: CustomScrollView(slivers: [
            // SliverAppBar(title: ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageViewScreen(
                                  path: data.pets[widget.index].image!,
                                ))),
                    child: Hero(
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
                      tag: data.pets[widget.index].name!,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(45),
                            bottomRight: Radius.circular(45)),
                        child: Image.asset(data.pets[widget.index].image!),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: kPadding,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.pets[widget.index].name!,
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '\u{20B9}${data.pets[widget.index].price!.toString()}',
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: kPadding,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.pin_drop),
                            SizedBox(
                              width: kPadding,
                            ),
                            Text("Santacruz, Mumbai 400055"),
                          ],
                        ),
                        const SizedBox(
                          height: kPadding,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 80,
                              height: 65,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: isDark
                                      ? Colors.black54
                                      : Colors.grey[300]),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Age "),
                                  const SizedBox(
                                    height: kPadding / 2,
                                  ),
                                  Text(" ${data.pets[widget.index].age} Year"),
                                ],
                              ),
                            ),
                            Container(
                              width: 80,
                              height: 65,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: isDark
                                      ? Colors.black54
                                      : Colors.grey[300]),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("Sex"),
                                  SizedBox(
                                    height: kPadding / 2,
                                  ),
                                  Text("Male"),
                                ],
                              ),
                            ),
                            Container(
                              width: 80,
                              height: 65,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: isDark
                                      ? Colors.black54
                                      : Colors.grey[300]),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("Breed"),
                                  SizedBox(
                                    height: kPadding / 2,
                                  ),
                                  Text("Indian"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: kPadding * 2,
                        ),
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: kGreenColor,
                              radius: 25,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: kPadding,
                            ),
                            Column(
                              children: const [
                                Text(
                                  "Sam ",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("Pet's owner"),
                              ],
                            ),
                            const Spacer(),
                            Card(
                              elevation: 2,
                              child: IconButton(
                                  tooltip: "Call owner",
                                  onPressed: () {},
                                  icon: const Icon(Icons.phone)),
                            ),
                            Card(
                              elevation: 2,
                              child: IconButton(
                                  tooltip: "Message owner",
                                  onPressed: () {},
                                  icon: const Icon(Icons.message)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        );
      }),
    );
  }
}
