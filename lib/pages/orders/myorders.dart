import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  MyOrders({Key key}) : super(key: key);
  @override
  _MyOrdersState createState() => _MyOrdersState();
}
class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [],
      ),
    );
  }
  buildOrders(String id, String nameorder, String status) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("رقم الطلب : 1"),
          Text("اسم الطلب : ؟؟"),
          // Text("نوع الطلب : ؟؟"),
          Text("حالة الطلب : بانتظار الموافقة"),
        ],
      ),
    ));
  }
}
