class Product {
  final String id, name, image;
  final double price;
  Product({required this.id, required this.name, required this.price, required this.image});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id, 'name': name, 'price': price, 'image': image,
  };
}
