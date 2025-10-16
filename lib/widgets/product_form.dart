import 'package:flutter/material.dart';

class ProductForm extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController priceCtrl;
  final TextEditingController yearCtrl;
  final VoidCallback onSubmit;
  final String buttonText;

  const ProductForm({
    super.key,
    required this.nameCtrl,
    required this.priceCtrl,
    required this.yearCtrl,
    required this.onSubmit,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(
              labelText: 'ชื่อสินค้า',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: priceCtrl,
            decoration: const InputDecoration(
              labelText: 'ราคา (บาท)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: yearCtrl,
            decoration: const InputDecoration(
              labelText: 'ปีที่ผลิต',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: onSubmit,
            icon: const Icon(Icons.save),
            label: Text(buttonText),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              backgroundColor: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
