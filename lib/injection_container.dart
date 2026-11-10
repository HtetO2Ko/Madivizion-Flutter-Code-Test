import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/database/app_database.dart';
import 'core/database/banner_seeder.dart';
import 'core/database/member_seeder.dart';
import 'core/database/product_seeder.dart';
import 'core/database/shop_seeder.dart';
import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'core/services/image_downloader.dart' show ImageDownloader;
import 'features/home/data/datasources/banner_local_data_source.dart';
import 'features/home/data/datasources/member_local_data_source.dart';
import 'features/home/data/datasources/product_local_data_source.dart';
import 'features/home/data/datasources/shop_local_data_source.dart';
import 'features/home/data/repositories/banner_repository_impl.dart'
    show BannerRepositoryImpl;
import 'features/home/data/repositories/member_repository_impl.dart';
import 'features/home/data/repositories/product_repository_impl.dart';
import 'features/home/data/repositories/shop_repository_impl.dart';
import 'features/home/domain/repositories/banner_repository.dart';
import 'features/home/domain/repositories/member_repository.dart';
import 'features/home/domain/repositories/product_repository.dart';
import 'features/home/domain/repositories/shop_repository.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase.instance);

  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<AppDatabase>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthLocalDataSource>()),
  );

  getIt.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
      ),
    ),
  );

  getIt.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSource(getIt<AppDatabase>()),
  );

  getIt.registerLazySingleton<ImageDownloader>(
    () => ImageDownloader(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ProductSeeder>(
    () => ProductSeeder(
      localDataSource: getIt<ProductLocalDataSource>(),
      imageDownloader: getIt<ImageDownloader>(),
    ),
  );

  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      localDataSource: getIt<ProductLocalDataSource>(),
      seeder: getIt<ProductSeeder>(),
    ),
  );

  getIt.registerLazySingleton<BannerLocalDataSource>(
    () => BannerLocalDataSource(getIt<AppDatabase>()),
  );

  getIt.registerLazySingleton<BannerSeeder>(
    () => BannerSeeder(
      localDataSource: getIt<BannerLocalDataSource>(),
      imageDownloader: getIt<ImageDownloader>(),
    ),
  );

  getIt.registerLazySingleton<BannerRepository>(
    () => BannerRepositoryImpl(getIt<BannerLocalDataSource>()),
  );

  getIt.registerLazySingleton<MemberLocalDataSource>(
    () => MemberLocalDataSource(getIt<AppDatabase>()),
  );

  getIt.registerLazySingleton<MemberRepository>(
    () => MemberRepositoryImpl(getIt<MemberLocalDataSource>()),
  );

  getIt.registerLazySingleton<MemberSeeder>(
    () => MemberSeeder(getIt<MemberLocalDataSource>()),
  );

  getIt.registerLazySingleton<ShopLocalDataSource>(
    () => ShopLocalDataSource(getIt<AppDatabase>()),
  );

  getIt.registerLazySingleton<ShopSeeder>(
    () => ShopSeeder(
      localDataSource: getIt<ShopLocalDataSource>(),
      imageDownloader: getIt<ImageDownloader>(),
    ),
  );

  getIt.registerLazySingleton<ShopRepository>(
    () => ShopRepositoryImpl(getIt<ShopLocalDataSource>()),
  );
}
