import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SalaryPage extends StatefulWidget {
  @override
  _SalaryPageState createState() => _SalaryPageState();
}

class _SalaryPageState extends State<SalaryPage> {
  List data = [];

  // ดึงข้อมูลจากฐานข้อมูล
  Future getData() async {
    var url = Uri.parse("http://10.0.2.2:5000/get");

    var response = await http.get(url);

    setState(() {
      data = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Salary Calculation")),

      body: ListView.builder(
        itemCount: data.length,

        itemBuilder: (context, index) {
          // ดึงเงินเดือนจาก DB
          double salary = double.parse(data[index]['total'].toString());

          // คำนวณภาษี
          double tax = salary * 0.07;

          // คำนวณเงินสุทธิ
          double net = salary - tax;

          return Card(
            child: ListTile(
              title: Text(data[index]['name']),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Salary : $salary"),

                  Text("Tax 7% : $tax"),

                  Text("Net Salary : $net"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
