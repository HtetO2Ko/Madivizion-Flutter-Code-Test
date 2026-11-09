import 'package:flutter/material.dart';
import '../../../../core/widgets/terms_and_service.dart';

class TermsContainer extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: TermsAndService(),
        ),
      ),
    );
  }
}
