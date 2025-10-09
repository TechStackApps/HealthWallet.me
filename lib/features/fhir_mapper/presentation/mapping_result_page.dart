import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MappingResultPage extends StatelessWidget {
  const MappingResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapping result"),
      ),
    );
  }
}
