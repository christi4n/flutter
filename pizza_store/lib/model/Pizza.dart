class Pizza {
  final String id;
  final String title;
  final String composition;
  final String price;
  final String imageUrl;

  Pizza({this.id, this.title, this.composition, this.price, this.imageUrl});

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: json['id'].toString(),
      title: json['title'] as String,
      composition: json['composition'] as String,
      price: json['price'] as String,
      imageUrl: json['imageUrl'] as String
      // imageUrl: Uri.parse(json['imageUrl'])
    );
  }
}