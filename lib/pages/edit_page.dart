import 'package:flutter/material.dart';
import '../services/pocketbase_service.dart';
import '../models/product_model.dart';


class EditPage extends StatefulWidget {
  final String id;
  final String name;
  final String price;
  final String year;

  const EditPage({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.year,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final service = PocketBaseService();
  late TextEditingController nameCtrl;
  late TextEditingController priceCtrl;
  late TextEditingController yearCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.name);
    priceCtrl = TextEditingController(text: widget.price);
    yearCtrl = TextEditingController(text: widget.year);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: priceCtrl, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
            TextField(controller: yearCtrl, decoration: const InputDecoration(labelText: 'Year'), keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await service.updateProduct(
  widget.id,
  Product(
    id: widget.id,
    name: nameCtrl.text,
    price: double.parse(priceCtrl.text),
    year: int.parse(yearCtrl.text),
    created: DateTime.now(),
    updated: DateTime.now(),
  ),
);

                if (mounted) Navigator.pop(context);
              },
              child: const Text('บันทึกการแก้ไข'),
            ),
          ],
        ),
      ),
    );
  }
}
