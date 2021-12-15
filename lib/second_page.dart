/// Made by Tejas Mehta
/// Made on Monday, December 13, 2021
/// File Name: second_page.dart

import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  ///Main widget build method
  ///Builds the UI on this screen
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: const Text("Second Page"),
  );
}
