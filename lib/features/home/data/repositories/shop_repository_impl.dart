import '../../domain/entities/shop.dart';
import '../../domain/repositories/shop_repository.dart';
import '../datasources/shop_local_data_source.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopLocalDataSource localDataSource;

  ShopRepositoryImpl(this.localDataSource);

  @override
  Future<List<Shop>> getShops() {
    return localDataSource.getShops();
  }
}
