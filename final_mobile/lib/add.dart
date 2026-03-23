import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController name = TextEditingController();
  TextEditingController day = TextEditingController();
  TextEditingController rate = TextEditingController();

  // บันทึกข้อมูล
  Future saveData() async {
    int workday = int.parse(day.text);
    double salaryRate = double.parse(rate.text);

    // คำนวณเงินเดือน
    double total = workday * salaryRate;

    var url = Uri.parse("http://10.0.2.2/flutter_api/insert.php");

    await http.post(
      url,
      body: {
        "name": name.text,
        "age": workday.toString(),
        "salary": salaryRate.toString(),
        "total": total.toString(),
      },
    );

    // แสดง dialog บันทึกสำเร็จ
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(title: Text("Success"), content: Text("Data Saved"));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Employee")),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [
            // ชื่อพนักงาน
            TextField(
              controller: name,
              decoration: InputDecoration(labelText: "Name"),
            ),

            // จำนวนวันทำงาน
            TextField(
              controller: day,
              decoration: InputDecoration(labelText: "Work Day"),
            ),

            // ค่าแรงต่อวัน
            TextField(
              controller: rate,
              decoration: InputDecoration(labelText: "Rate / Day"),
            ),

            SizedBox(height: 20),

            ElevatedButton(onPressed: saveData, child: Text("Save Data")),
          ],
        ),
      ),
    );
  }
}
