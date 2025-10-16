import 'package:pocketbase/pocketbase.dart';
import '../models/product_model.dart';

class PocketBaseService {
  final pb = PocketBase('http://localhost:8090');


  // ✅ เพิ่ม method ชื่อ getAllProducts
  Future<List<Product>> getAllProducts() async {
    final result = await pb.collection('fianlproject').getFullList();
    return result.map((record) => Product.fromRecord(record)).toList();
  }

  Future<void> addProduct(Product product) async {
    await pb.collection('fianlproject').create(body: product.toJson());
  }

  Future<void> updateProduct(String id, Product product) async {
    await pb.collection('fianlproject').update(id, body: product.toJson());
  }

  Future<void> deleteProduct(String id) async {
    await pb.collection('fianlproject').delete(id);
  }
}
