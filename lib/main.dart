import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'fake_data.dart'; // ✅ ถ้าจะใช้สร้างข้อมูลจำลอง
// import 'services/pocketbase_service.dart'; // (optional ถ้าจะเชื่อมต่อ PocketBase ก่อนเริ่มแอป)

void main() async {
  // ✅ ต้องแน่ใจว่า Flutter ถูก initialize ก่อนเรียก async
  WidgetsFlutterBinding.ensureInitialized();

  // 🔹 (Optional) สร้างข้อมูลจำลองครั้งเดียวสำหรับเทส
  // final generator = FakeDataGenerator();
  // await generator.generateQuickSample();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Final Project CRUD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      home: const HomePage(),
    );
  }
}
