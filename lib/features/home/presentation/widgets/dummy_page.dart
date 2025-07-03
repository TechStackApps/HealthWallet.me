import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DummyPage extends StatelessWidget {
  const DummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dummy Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.router.maybePop(),
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}
