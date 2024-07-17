  import 'package:flutter/material.dart';

class OnboardContent extends StatelessWidget {
    final String imageURL;
    final String title;
    final String desc;

    const OnboardContent(
        {super.key,
        required this.imageURL,
        required this.title,
        required this.desc});

    @override
    Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imageURL,
            height: 300,
            width: 300,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            desc,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          )
        ],
      );
    }
  }
