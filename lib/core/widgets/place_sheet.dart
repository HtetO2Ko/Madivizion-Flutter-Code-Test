import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlaceSheet extends StatelessWidget {
  final String page;
  const new({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(onPressed: () => context.pop())),
      body: Center(child: Text("$page coming soon!!!")),
    );
  }
}
