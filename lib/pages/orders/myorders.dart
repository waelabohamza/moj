import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:moj/component/animatelist.dart';
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
  List orderscourses = [];
  List ordersservices = [];
  getInitialOrders() async {
    var responsebody = await crud
        .writeData(linkAllOrders, {"userid": sharedPrefs.getString("id")});
    print("====================================");
    print("====================================");
    print(responsebody['orderscourse']);
    print(responsebody['ordersservice']);
    if (responsebody['orderscourse'].toString() != "0") {
      orderscourses.addAll(responsebody['orderscourse']);
      // print("2222222") ;
    }
    if (responsebody['ordersservice'].toString() != "0") {
      orderscourses.addAll(responsebody['ordersservice']);
    }

    setState(() {});
  }

  @override
  void initState() {
    getInitialOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Container(
              margin: EdgeInsets.only(top: 50),
              child: (isactive == true)
                  ? (orderscourses.isEmpty || orderscourses == null)
                      ? Center(child: Text("Not Orders Courses"))
                      : LiveList.options(
                          shrinkWrap: true,
                          options: options,
                          itemCount: orderscourses.length,
                          itemBuilder: (BuildContext context, int index,
                              Animation<double> animation) {
                            return SlideTransition(
                                position: Tween<Offset>(
                                  begin: Offset(1, 0),
                                  end: Offset.zero,
                                ).animate(animation),
                                // Paste you Widget
                                child: buildOrders(
                                    orderscourses[index]['orderscourse_id'],
                                    orderscourses[index]['courses_name'],
                                    orderscourses[index]['orderscourse_status'],
                                    "courses"));
                          },
                        )
                  : (ordersservices.isEmpty || ordersservices == null)
                      ? Center(child: Text("Not Orders Services"))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: ordersservices.length,
                          itemBuilder: (context, i) {
                            return buildOrders(
                                ordersservices[i]['ordersservice_id'],
                                ordersservices[i]['services_name'],
                                ordersservices[i]['ordersservice_status'],
                                "services");
                          })),
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

  buildOrders(ordersid, ordersname, ordersstatus, type) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("رقم الطلب : $ordersid"),
          Text("اسم الطلب : $ordersname "),
          int.parse(ordersstatus) == 0
              ? Text(
                  "حالة الطلب :  بانتظار  الموافقة ",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                )
              : int.parse(ordersstatus) == 1
                  ? Text("حالة الطلب :  تمت الموافقة  ",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold))
                  : Text("حالة الطلب :  مرفوض  ",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
        ],
      ),
    ));
  }
}

// import 'package:flutter/material.dart';
// import 'package:moj/component/crud.dart';
// import 'package:moj/main.dart';
// import 'package:moj/pages/linkapi.dart';

// class MyOrders extends StatefulWidget {
//   MyOrders({Key key}) : super(key: key);
//   @override
//   _MyOrdersState createState() => _MyOrdersState();
// }
// class _MyOrdersState extends State<MyOrders> {
//   bool isactive = false;
//   Crud crud = new Crud();
//   List orderscourses = [];
//   List ordersservices = [];
//   getInitialOrders() async {
//     var responsebody = await crud
//         .writeData(linkAllOrders, {"userid": sharedPrefs.getString("id")});
//     orderscourses.addAll(responsebody['orderscourse']);
//     ordersservices.addAll(responsebody['ordersservice']);
//     setState(() {});
//   }
//   @override
//   void initState() {
//     getInitialOrders();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       child: Stack(
//         children: [
//           Container(
//               margin: EdgeInsets.only(top: 50),
//               child: orderscourses.isNotEmpty && orderscourses != null
//                   ? (isactive == true)
//                       ? ListView.builder(
//                           shrinkWrap: true,
//                           // physics: NeverScrollableScrollPhysics(),
//                           itemCount: orderscourses.length,
//                           itemBuilder: (context, i) {
//                             return buildOrders(
//                                 orderscourses[i]['orderscourse_id'],
//                                 orderscourses[i]['courses_name'],
//                                 orderscourses[i]['orderscourse_status'],
//                                 "courses");
//                           })
//                       : ListView.builder(
//                           shrinkWrap: true,
//                           // physics: NeverScrollableScrollPhysics(),
//                           itemCount: ordersservices.length,
//                           itemBuilder: (context, i) {
//                             return buildOrders(
//                                 ordersservices[i]['ordersservice_id'],
//                                 ordersservices[i]['services_name'],
//                                 ordersservices[i]['ordersservice_status'],
//                                 "services");
//                           })
//                   : Center(child: CircularProgressIndicator())),
//           Row(
//             children: [
//               Expanded(
//                   child: MaterialButton(
//                       shape: Border.all(color: Theme.of(context).primaryColor),
//                       color: isactive == true
//                           ? Theme.of(context).primaryColor
//                           : Colors.white,
//                       textColor: isactive == true
//                           ? Colors.white
//                           : Theme.of(context).primaryColor,
//                       onPressed: () {
//                         setState(() {
//                           isactive = true;
//                         });
//                       },
//                       child: Text("الدورات"))),
//               Expanded(
//                   child: MaterialButton(
//                       shape: Border.all(color: Theme.of(context).primaryColor),
//                       color: isactive == false
//                           ? Theme.of(context).primaryColor
//                           : Colors.white,
//                       textColor: isactive == false
//                           ? Colors.white
//                           : Theme.of(context).primaryColor,
//                       onPressed: () {
//                         setState(() {
//                           isactive = false;
//                         });
//                       },
//                       child: Text("الخدمات"))),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   buildOrders(ordersid, ordersname, ordersstatus, type) {
//     return Card(
//         child: Container(
//       padding: EdgeInsets.all(10),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("رقم الطلب : $ordersid"),
//           Text("اسم الطلب : $ordersname "),
//           int.parse(ordersstatus) == 0
//               ? Text(
//                   "حالة الطلب :  بانتظار  الموافقة ",
//                   style: TextStyle(
//                       color: Colors.blue, fontWeight: FontWeight.bold),
//                 )
//               : int.parse(ordersstatus) == 1
//                   ? Text("حالة الطلب :  تمت الموافقة  ",
//                       style: TextStyle(
//                           color: Colors.green, fontWeight: FontWeight.bold))
//                   : Text("حالة الطلب :  مرفوض  ",
//                       style: TextStyle(
//                           color: Colors.red, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     ));
//   }
// }
