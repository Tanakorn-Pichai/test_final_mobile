import 'package:flutter/material.dart';
import 'home.dart';
import 'add.dart';
import 'salary_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0; // เก็บ index ของเมนูที่เลือก

  // รายชื่อหน้าทั้งหมดในแอพ
  final List<Widget> _pages = [HomePage(), AddPage(), SalaryPage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        // แสดงหน้าตาม index
        body: _pages[_selectedIndex],

        // เมนูด้านล่าง
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,

          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },

          items: const [
            // หน้าแรก
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

            // หน้าเพิ่มข้อมูล
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),

            // หน้าคำนวณเงินเดือน
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: "Salary",
            ),
          ],
        ),
      ),
    );
  }
}
