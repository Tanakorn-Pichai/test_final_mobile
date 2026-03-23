import 'dart:convert'; // ใช้แปลง JSON
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'edit.dart'; // หน้าแก้ไขข้อมูล

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // ตัวแปรเก็บข้อมูลจากฐานข้อมูล
  List data = [];

  // ===============================
  // ฟังก์ชันดึงข้อมูลจากฐานข้อมูล
  // ===============================
  Future getData() async {

    var url = Uri.parse("http://10.0.2.2/flutter_api/get.php");

    var response = await http.get(url);

    setState(() {
      data = jsonDecode(response.body);
    });

  }

  // ===============================
  // ฟังก์ชันลบข้อมูล
  // ===============================
  Future deleteData(id) async {

    var url = Uri.parse("http://10.0.2.2/flutter_api/delete.php");

    await http.post(url, body: {
      "id": id
    });

    // โหลดข้อมูลใหม่หลังลบ
    getData();
  }

  // ===============================
  // โหลดข้อมูลเมื่อเปิดหน้า
  // ===============================
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // ===============================
      // AppBar ด้านบน
      // ===============================
      appBar: AppBar(
        title: Text("Employee List"),
      ),

      // ===============================
      // แสดงข้อมูลจากฐานข้อมูล
      // ===============================
      body: ListView.builder(

        itemCount: data.length,

        itemBuilder: (context,index){

          // ดึงเงินเดือนจากฐานข้อมูล
          double salary = double.parse(data[index]['total']);

          return Card(

            child: ListTile(

              // ===============================
              // แสดงชื่อพนักงาน
              // ===============================
              title: Text(data[index]['name']),

              // ===============================
              // แสดงรายละเอียด
              // ===============================
              subtitle: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text("Work Day : ${data[index]['age']}"),

                  Text("Salary : $salary"),

                  // ===============================
                  // เงื่อนไขแสดงผล
                  // ===============================
                  salary > 20000
                      ? Text(
                          "High Salary",
                          style: TextStyle(color: Colors.green),
                        )
                      : Text(
                          "Normal Salary",
                          style: TextStyle(color: Colors.red),
                        )

                ],
              ),

              // ===============================
              // ปุ่ม Edit และ Delete
              // ===============================
              trailing: Row(

                mainAxisSize: MainAxisSize.min,

                children: [

                  // ===============================
                  // ปุ่มแก้ไขข้อมูล
                  // ===============================
                  IconButton(

                    icon: Icon(Icons.edit, color: Colors.blue),

                    onPressed: () async {

                      await Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (context) => EditPage(
                            data: data,
                            index: index,
                          ),

                        ),
                      );

                      // refresh ข้อมูลหลังแก้ไข
                      getData();
                    },
                  ),

                  // ===============================
                  // ปุ่มลบข้อมูล
                  // ===============================
                  IconButton(

                    icon: Icon(Icons.delete, color: Colors.red),

                    onPressed: () {

                      deleteData(data[index]['id']);

                    },
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}