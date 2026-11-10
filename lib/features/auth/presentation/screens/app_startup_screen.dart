import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/banner_seeder.dart';
import '../../../../core/database/member_seeder.dart';
import '../../../../core/database/product_seeder.dart';
import '../../../../core/database/shop_seeder.dart';
import '../../../../core/storage/session_storage.dart';

import '../../../../app/router/route_names.dart';
import '../../../../injection_container.dart';
import '../../data/datasources/auth_local_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';

class AppStartupScreen extends StatefulWidget {
  const AppStartupScreen({super.key});

  @override
  State<AppStartupScreen> createState() => _AppStartupScreenState();
}

class _AppStartupScreenState extends State<AppStartupScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    try {
      final phoneNumber = await SessionStorage.getPhoneNumber();

      if (!mounted) return;

      if (phoneNumber == null || phoneNumber.isEmpty) {
        context.goNamed(AppRouteNames.onboarding);
        return;
      }

      final repository = AuthRepositoryImpl(
        AuthLocalDataSource(AppDatabase.instance),
      );

      final user = await repository.getUserByPhone(phoneNumber);

      if (!mounted) return;

      if (user != null) {
        await getIt<ProductSeeder>().seedIfNeeded();
        await getIt<BannerSeeder>().seedIfNeeded();
        await getIt<MemberSeeder>().seedIfNeeded();
        await getIt<ShopSeeder>().seedIfNeeded();
        context.goNamed(AppRouteNames.tabbar);
      } else {
        await SessionStorage.clearSession();

        if (!mounted) return;
        context.goNamed(AppRouteNames.onboarding);
      }
    } catch (_) {
      if (!mounted) return;

      context.goNamed(AppRouteNames.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
