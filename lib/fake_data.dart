import 'package:pocketbase/pocketbase.dart';
import 'package:faker/faker.dart';

void main() async {
  final pb = PocketBase('http://127.0.0.1:8090');
  final faker = Faker();

  for (int i = 0; i < 10; i++) {
    final name = faker.food.restaurant();
    final price = faker.randomGenerator.decimal(scale: 900) + 100;
    final year = faker.date.dateTime(minYear: 2015, maxYear: 2025).year;

    await pb.collection('fianlproject').create(body: {
      'name': name,
      'price': price,
      'year': year,
    });

    print('✅ เพิ่มข้อมูลสินค้า: $name ราคา $price ปี $year');
  }

  print('\n🎉 เพิ่มข้อมูลจำลองเสร็จสิ้น!');
}
