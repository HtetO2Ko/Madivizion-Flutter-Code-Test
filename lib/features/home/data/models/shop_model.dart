import '../../domain/entities/shop.dart';

class ShopModel extends Shop {
  const ShopModel({
    required super.id,
    required super.name,
    required super.address,
    required super.imageUrl,
    super.localImagePath,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      imageUrl: json['imageUrl'] as String,
      localImagePath: json['localImagePath'] as String?,
    );
  }

  factory ShopModel.fromMap(Map<String, dynamic> map) {
    return ShopModel(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      imageUrl: map['image_url'] as String,
      localImagePath: map['local_image_path'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'image_url': imageUrl,
      'local_image_path': localImagePath,
    };
  }

  ShopModel copyWith({String? localImagePath}) {
    return ShopModel(
      id: id,
      name: name,
      address: address,
      imageUrl: imageUrl,
      localImagePath: localImagePath ?? this.localImagePath,
    );
  }
}
