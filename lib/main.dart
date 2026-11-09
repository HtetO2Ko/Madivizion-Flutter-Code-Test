import 'package:flutter/material.dart';
// import 'package:j_donut/core/database/app_database.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await AppDatabase.instance.deleteDatabaseFile();
  runApp(const JDonutApp());
}
