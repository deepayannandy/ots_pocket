import 'package:flutter/material.dart';

class ImageUtil extends StatelessWidget {
  final double? height;
  final double? width;
  final String? path;


  const ImageUtil({required this.height, required this.width, this.path,  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Image.asset(path!,),
    );
  }
}
