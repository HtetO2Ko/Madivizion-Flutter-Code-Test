import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../auth/data/datasources/auth_local_data_source.dart';
import '../../../auth/data/repositories/auth_repository_impl.dart';
import '../../../auth/domain/entities/auth.dart';

class HomeScreen extends StatefulWidget {
  final String phoneNumber;

  const HomeScreen({super.key, required this.phoneNumber});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<Auth?> _userFuture;

  @override
  void initState() {
    super.initState();


    final repository = AuthRepositoryImpl(
      AuthLocalDataSource(AppDatabase.instance),
    );

    _userFuture = repository.getUserByPhone(widget.phoneNumber);
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
