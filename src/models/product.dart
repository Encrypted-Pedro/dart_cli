import 'dart:convert';

class Product {
  Product({
    this.id,
    this.title,
    this.paid,
  });

  final int? id;
  final String? title;
  bool? paid;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'paid': paid,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['id'] ?? 0,
        title: map['title'] ?? '',
        paid: map['paid'] ?? false);
  }

  factory Product.fromJson(String json) => Product.fromMap(jsonDecode(json));
}
