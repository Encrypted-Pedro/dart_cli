import 'dart:convert';
import 'address.dart';
import 'paid_verify.dart';

class Bound {
  Bound({
    this.id,
    this.name,
    this.age,
    this.productBound,
    this.paidVerify,
    this.address,
  });

  final int? id;
  final String? name;
  final int? age;
  final List<String>? productBound;
  final List<PaidVerify>? paidVerify;
  final Address? address;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'productBound': productBound,
      'paidVerify': paidVerify?.map((e) => e.toMap()).toList(),
      'address': address?.toMap(),
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Bound.fromMap(Map<String, dynamic> map) {
    return Bound(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      age: map['age'],
      productBound: List<String>.from(map['productsBound'] ?? <String>[]),
      paidVerify: (map['paidVerify'] as List<dynamic>)
          .map((e) => PaidVerify.fromMap(e))
          .toList(),
      address: Address.fromMap(map['address']),
    );
  }
  factory Bound.fromJson(String json) => Bound.fromMap(jsonDecode(json));
}
