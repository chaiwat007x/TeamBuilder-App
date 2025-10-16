import 'package:pocketbase/pocketbase.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final int year;
  final DateTime created;
  final DateTime updated;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.year,
    required this.created,
    required this.updated,
  });

  /// ✅ แปลงจาก RecordModel ของ PocketBase เป็น Object Product
  factory Product.fromRecord(RecordModel record) {
    final data = record.data;
    return Product(
      id: record.id,
      name: data['name'] ?? '',
      price: (data['price'] is int)
          ? (data['price'] as int).toDouble()
          : (data['price'] ?? 0.0),
      year: data['year'] ?? 0,
      created: DateTime.parse(record.created),
      updated: DateTime.parse(record.updated),
    );
  }

  /// ✅ แปลงกลับเป็น Map เพื่อส่งกลับไปยัง PocketBase (เวลา create/update)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'year': year,
    };
  }
}
