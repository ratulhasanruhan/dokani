class ProductModel {
  final int id;
  final String title;
  final String description;
  final num price;
  final num rating;
  final String category;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      rating: json['rating'],
      category: json['category'],
      images: List<String>.from(json['images'] ?? []),
    );
  }
}