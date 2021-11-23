import 'package:flutter/material.dart';

class TextScreen extends StatelessWidget {
  final String textData;
  final String appBarTitle;
  final TextButton? button;

  const TextScreen({
    Key? key,
    required this.textData,
    required this.appBarTitle,
    this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          child: Column(
            children: [
              Text(
                textData,
                textAlign: TextAlign.left,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 18,
                  letterSpacing: 2,
                ),
              ),
              button ?? Container(),
            ],
          ),
        ),
      ),
    );
  }
}
