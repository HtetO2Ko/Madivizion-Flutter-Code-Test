import '../entities/shop.dart';

abstract class ShopRepository {
  Future<List<Shop>> getShops();
}
