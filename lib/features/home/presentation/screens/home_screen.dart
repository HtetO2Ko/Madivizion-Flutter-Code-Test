import 'package:flutter/material.dart';

import '../../../../core/storage/session_storage.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../../injection_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<Auth?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _loadUser();
  }

  Future<Auth?> _loadUser() async {
    final phoneNumber = await SessionStorage.getPhoneNumber();

    if (phoneNumber == null || phoneNumber.isEmpty) {
      return null;
    }

    final repository = getIt<AuthRepository>();

    return repository.getUserByPhone(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("J'Donuts")),
      body: FutureBuilder<Auth?>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Unable to load user information.'),
            );
          }

          final user = snapshot.data;

          if (user == null) {
            return const Center(child: Text('User not found.'));
          }

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, ${user.firstName}!',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text('First name: ${user.firstName}'),
                Text('Last name: ${user.lastName}'),
                Text('Phone: ${user.phone}'),
                Text(
                  'Date of birth: '
                  '${user.dateOfBirth.day}/'
                  '${user.dateOfBirth.month}/'
                  '${user.dateOfBirth.year}',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
