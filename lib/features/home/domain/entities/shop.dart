class Shop {
  final String id;
  final String name;
  final String address;
  final String imageUrl;
  final String? localImagePath;

  const Shop({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
    this.localImagePath,
  });
}
