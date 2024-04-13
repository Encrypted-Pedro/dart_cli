import 'dart:convert';

class PaidVerify {
  PaidVerify({
    this.id,
    this.product,
    this.paid,
  });

  final int? id;
  final String? product;
  final bool? paid;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product': product,
      'paid': paid,
    };
  }

  String toJson() => jsonEncode(toMap());
  factory PaidVerify.fromMap(Map<String, dynamic> map) {
    return PaidVerify(
        id: map['id'] ?? 0,
        product: map['product'] ?? '',
        paid: map['paid'] ?? false);
  }
  factory PaidVerify.fromJson(String json) =>
      PaidVerify.fromMap(jsonDecode(json));
}
