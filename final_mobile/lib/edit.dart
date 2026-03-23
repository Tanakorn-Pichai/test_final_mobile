import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  // รับข้อมูลจากหน้า Home
  final List data;
  final int index;

  EditPage({required this.data, required this.index});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  // controller สำหรับ TextField
  TextEditingController name = TextEditingController();
  TextEditingController day = TextEditingController();
  TextEditingController rate = TextEditingController();

  @override
  void initState() {
    // นำค่าจากฐานข้อมูลมาใส่ใน TextField
    name.text = widget.data[widget.index]['name'];
    day.text = widget.data[widget.index]['age'];
    rate.text = widget.data[widget.index]['salary'];

    super.initState();
  }

  // ฟังก์ชันอัปเดตข้อมูล
  Future updateData() async {
    int workday = int.parse(day.text);
    double salaryRate = double.parse(rate.text);

    // คำนวณเงินเดือนใหม่
    double total = workday * salaryRate;

    var url = Uri.parse("http://10.0.2.2/flutter_api/update.php");

    await http.post(
      url,
      body: {
        "id": widget.data[widget.index]['id'], // id ของข้อมูล
        "name": name.text,
        "age": workday.toString(),
        "salary": salaryRate.toString(),
        "total": total.toString(),
      },
    );

    // กลับไปหน้า Home
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Employee"), // หัวข้อหน้า
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [
            // ช่องแก้ไขชื่อ
            TextField(
              controller: name,
              decoration: InputDecoration(labelText: "Name"),
            ),

            // ช่องแก้ไขจำนวนวันทำงาน
            TextField(
              controller: day,
              decoration: InputDecoration(labelText: "Work Day"),
            ),

            // ช่องแก้ไขค่าแรงต่อวัน
            TextField(
              controller: rate,
              decoration: InputDecoration(labelText: "Rate / Day"),
            ),

            SizedBox(height: 20),

            // ปุ่ม Update
            ElevatedButton(onPressed: updateData, child: Text("Update Data")),
          ],
        ),
      ),
    );
  }
}
