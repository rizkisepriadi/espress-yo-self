class ProductEntity {
  final String id;
  final String name;
  final String description;
  final String price;
  final String category;
  final String imageUrl;
  final String image250Url;
  final String? discount;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.image250Url,
    this.discount,
  });
}
