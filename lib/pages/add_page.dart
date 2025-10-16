import 'package:flutter/material.dart';
import '../services/pocketbase_service.dart';
import '../models/product_model.dart'; // ✅ อย่าลืม import ด้วย

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final service = PocketBaseService();
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final yearCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: priceCtrl,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: yearCtrl,
              decoration: const InputDecoration(labelText: 'Year'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await service.addProduct(
                  Product(
                    id: '', // id จะสร้างอัตโนมัติใน PocketBase
                    name: nameCtrl.text,
                    price: double.parse(priceCtrl.text),
                    year: int.parse(yearCtrl.text),
                    created: DateTime.now(),
                    updated: DateTime.now(),
                  ),
                );
                if (mounted) Navigator.pop(context);
              },
              child: const Text('เพิ่มสินค้า'),
            ),
          ],
        ),
      ),
    );
  }
}
