import '../../../../core/database/product_seeder.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;
  final ProductSeeder seeder;

  ProductRepositoryImpl({required this.localDataSource, required this.seeder});

  @override
  Future<Product?> getProductById(String id) async {
    final model = await localDataSource.getProductById(id);
    if (model == null) return null;
    return Product(
      id: model.id,
      code: model.code,
      name: model.name,
      priceMmk: model.priceMmk,
      isNew: model.isNew,
      discountPercent: model.discountPercent,
      imageUrl: model.imageUrl,
      localImagePath: model.localImagePath,
      description: model.description,
    );
  }

  @override
  Future<List<Product>> getProducts() async {
    final models = await localDataSource.getProducts();

    return models.map((model) {
      return Product(
        id: model.id,
        code: model.code,
        name: model.name,
        priceMmk: model.priceMmk,
        isNew: model.isNew,
        discountPercent: model.discountPercent,
        imageUrl: model.imageUrl,
        localImagePath: model.localImagePath,
        description: model.description,
      );
    }).toList();
  }

  @override
  Future<void> seedProducts() {
    return seeder.seedIfNeeded();
  }
}
