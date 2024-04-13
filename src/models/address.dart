import 'dart:convert';

import 'city.dart';
import 'phone.dart';

class Address {
  Address({
    this.street,
    this.number,
    this.zipCode,
    this.city,
    this.phone,
  });

  final String? street;
  final int? number;
  final String? zipCode;
  final City? city;
  final Phone? phone;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'street': street,
      'number': number,
      'zipCode': zipCode,
      'city': city?.toMap(),
      'phone': phone?.toMap(),
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
        street: map['street'] ?? '',
        number: map['number'] ?? 0,
        zipCode: map['zipCode'] ?? '',
        city: City.fromMap(map['city'] ?? <String, dynamic>{}),
        phone: Phone.fromMap(map['phone'] ?? <String, dynamic>{}));
  }
  factory Address.fromJson(String json) => Address.fromMap(jsonDecode(json));
}
