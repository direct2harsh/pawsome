import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:pawsome/helpers/constants.dart';

class AdoptedAlertBox extends StatelessWidget {
  final String name;
  const AdoptedAlertBox({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    ConfettiController controller =
        ConfettiController(duration: const Duration(seconds: 10));
    controller.play();
    const Gradient gradient =
        LinearGradient(colors: [Colors.red, Colors.green, Colors.blue]);
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      icon: const Icon(
        Icons.pets_rounded,
        size: 40,
        color: kGreenColor,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => gradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: const Text(
              "Pawsome!!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text("You have now adopted $name."),
          ConfettiWidget(
            confettiController: controller,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text("Ok"))
      ],
    );
  }
}
