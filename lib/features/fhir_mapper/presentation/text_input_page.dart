import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TextInputPage extends StatelessWidget {
  const TextInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text input"),
      ),
    );
  }
}
