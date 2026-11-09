import '../../domain/entities/banner.dart' as entity;
import '../../domain/repositories/banner_repository.dart';
import '../datasources/banner_local_data_source.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerLocalDataSource localDataSource;

  BannerRepositoryImpl(this.localDataSource);

  @override
  Future<List<entity.Banner>> getBanners() async {
    final models = await localDataSource.getBanners();

    return models.map((model) {
      return entity.Banner(
        id: model.id,
        imageUrl: model.imageUrl,
        localImagePath: model.localImagePath,
      );
    }).toList();
  }
}
