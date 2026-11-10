import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/database/banner_seeder.dart';
import 'core/database/member_seeder.dart';
import 'core/database/product_seeder.dart';
import 'core/database/shop_seeder.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();

  // seed data on first launch.
  await getIt<ProductSeeder>().seedIfNeeded();
  await getIt<BannerSeeder>().seedIfNeeded();
  await getIt<MemberSeeder>().seedIfNeeded();
  await getIt<ShopSeeder>().seedIfNeeded();
  runApp(const JDonutApp());
}
