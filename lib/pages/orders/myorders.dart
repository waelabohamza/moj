import 'package:flutter/material.dart';
import 'package:moj/component/crud.dart';
import 'package:moj/main.dart';
import 'package:moj/pages/linkapi.dart';

class MyOrders extends StatefulWidget {
  MyOrders({Key key}) : super(key: key);
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  Crud crud = new Crud();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          FutureBuilder(
              future: crud.writeData(
                  linkMyOrdersCourse, {"userid": sharedPrefs.getString("id")}),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return buildOrders(snapshot.data[i]);
                      });
                }
                return Center(child: CircularProgressIndicator());
              })
        ],
      ),
    );
  }

  buildOrders(listorders) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("رقم الطلب : ${listorders['orderscourse_id']} "),
          Text("اسم الطلب :   ${listorders['courses_name_ar']}"),
          int.parse(listorders['orderscourse_status']) == 0
              ? Text("حالة الطلب :  بانتظار  الموافقة ")
              : Text("حالة الطلب :  تمت الموافقة  "),
          // Text("نوع الطلب : ؟؟"),
        ],
      ),
    ));
  }
}
