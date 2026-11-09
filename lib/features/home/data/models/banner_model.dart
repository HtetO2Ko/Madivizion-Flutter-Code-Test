class BannerModel {
  final String id;
  final String imageUrl;
  final String? localImagePath;

  const BannerModel({
    required this.id,
    required this.imageUrl,
    this.localImagePath,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      localImagePath: json['localImagePath'] as String?,
    );
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'] as String,
      imageUrl: map['image_url'] as String,
      localImagePath: map['local_image_path'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image_url': imageUrl,
      'local_image_path': localImagePath,
    };
  }
}
