class ProductModel {
  final String id;
  final String code;
  final String name;
  final int priceMmk;
  final bool isNew;
  final int? discountPercent;
  final String imageUrl;
  final String? localImagePath;
  final String description;

  const ProductModel({
    required this.id,
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    this.discountPercent,
    required this.imageUrl,
    this.localImagePath,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      priceMmk: json['priceMmk'] as int,
      isNew: json['isNew'] as bool,
      discountPercent: json['discountPercent'] as int?,
      imageUrl: json['imageUrl'] as String,
      localImagePath: json['localImagePath'] as String?,
      description: json['description'] as String,
    );
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      code: map['code'] as String,
      name: map['name'] as String,
      priceMmk: map['price_mmk'] as int,
      isNew: map['is_new'] == 1,
      discountPercent: map['discount_percent'] as int?,
      imageUrl: map['image_url'] as String,
      localImagePath: map['local_image_path'] as String?,
      description: map['description'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'price_mmk': priceMmk,
      'is_new': isNew ? 1 : 0,
      'discount_percent': discountPercent,
      'image_url': imageUrl,
      'local_image_path': localImagePath,
      'description': description,
    };
  }

  ProductModel copyWith({String? localImagePath}) {
    return ProductModel(
      id: id,
      code: code,
      name: name,
      priceMmk: priceMmk,
      isNew: isNew,
      discountPercent: discountPercent,
      imageUrl: imageUrl,
      localImagePath: localImagePath ?? this.localImagePath,
      description: description,
    );
  }
}
