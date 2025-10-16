import 'package:flutter/material.dart';
import '../services/pocketbase_service.dart';
import '../models/product_model.dart';          
import 'edit_page.dart';
import 'add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final service = PocketBaseService();
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = service.getAllProducts();
  }

  Future<void> _refreshProducts() async {
    setState(() {
      _productsFuture = service.getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FinalProject : รายการสินค้า',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          // กำลังโหลด
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // เกิดข้อผิดพลาด
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '❌ เกิดข้อผิดพลาด: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final products = snapshot.data ?? [];

          // ไม่มีข้อมูล
          if (products.isEmpty) {
            return const Center(
              child: Text(
                'ยังไม่มีข้อมูลสินค้า',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          // แสดงข้อมูลใน ListView
          return RefreshIndicator(
            onRefresh: _refreshProducts,
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 2,
                  child: ListTile(
                    leading: const Icon(Icons.shopping_bag, color: Colors.blue),
                    title: Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      "ราคา: ${product.price} บาท\nปีที่ผลิต: ${product.year}",
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('ลบสินค้า'),
                            content: const Text('คุณต้องการลบสินค้านี้หรือไม่?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('ยกเลิก'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('ลบ', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          await service.deleteProduct(product.id);
                          _refreshProducts();
                        }
                      },
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditPage(
                            id: product.id,
                            name: product.name,
                            price: product.price.toString(),
                            year: product.year.toString(),
                          ),
                        ),
                      );
                      _refreshProducts(); // refresh หลังกลับจากหน้าแก้ไข
                    },
                  ),
                );
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        icon: const Icon(Icons.add),
        label: const Text('เพิ่มสินค้า'),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddPage()),
          );
          _refreshProducts(); // refresh หลังจากเพิ่ม
        },
      ),
    );
  }
}
