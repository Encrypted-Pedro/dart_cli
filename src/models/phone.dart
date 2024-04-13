import 'dart:convert';

class Phone {
  Phone({
    this.ddd,
    this.phone,
  });

  final int? ddd;
  final String? phone;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ddd': ddd,
      'phone': phone,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Phone.fromMap(Map<String, dynamic> map) {
    return Phone(ddd: map['ddd'] ?? 0, phone: map['phone'] ?? '');
  }

  factory Phone.fromJson(String json) => Phone.fromMap(jsonDecode(json));
}
