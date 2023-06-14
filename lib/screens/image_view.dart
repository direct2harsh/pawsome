import 'package:flutter/material.dart';

import 'package:pinch_zoom/pinch_zoom.dart';

class ImageViewScreen extends StatelessWidget {
  final String path;

  const ImageViewScreen({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PinchZoom(
          resetDuration: const Duration(seconds: 2000),
          maxScale: 5,
          child: Image.asset(path)),
    );
  }
}
