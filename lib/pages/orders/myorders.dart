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
  bool isactive = false;
  Crud crud = new Crud();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          isactive == true
              ? Container(
                  margin: EdgeInsets.only(top: 50),
                  child: FutureBuilder(
                      future: crud.writeData(linkMyOrdersCourse,
                          {"userid": sharedPrefs.getString("id")}),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                return buildOrders(snapshot.data[i]);
                              });
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                )
              : Text("wael"),
          Row(
            children: [
              Expanded(
                  child: MaterialButton(
                      shape: Border.all(color: Theme.of(context).primaryColor),
                      color: isactive == true
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      textColor: isactive == true
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          isactive = true;
                        });
                      },
                      child: Text("الدورات"))),
              Expanded(
                  child: MaterialButton(
                      shape: Border.all(color: Theme.of(context).primaryColor),
                      color: isactive == false
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      textColor: isactive == false
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          isactive = false;
                        });
                      },
                      child: Text("الخدمات"))),
            ],
          ),
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
              ? Text(
                  "حالة الطلب :  بانتظار  الموافقة ",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                )
              : int.parse(listorders['orderscourse_status']) == 1
                  ? Text("حالة الطلب :  تمت الموافقة  ",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold))
                  : Text("حالة الطلب :  مرفوض  ",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
          // Text("نوع الطلب : ؟؟"),
        ],
      ),
    ));
  }
}
