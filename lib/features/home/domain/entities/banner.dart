class Banner {
  final String id;
  final String imageUrl;
  final String? localImagePath;

  const Banner({
    required this.id,
    required this.imageUrl,
    this.localImagePath,
  });
}
