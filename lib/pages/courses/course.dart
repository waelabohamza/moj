import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:moj/const.dart';

class Course extends StatefulWidget {
  final list;
  Course({Key key, this.list}) : super(key: key);

  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<Course> {
  Icon icon1 = Icon(Icons.add);
  Icon icon2 = Icon(Icons.add);
  Icon icon3 = Icon(Icons.add);
  Icon icon4 = Icon(Icons.add);
  Icon icon5 = Icon(Icons.add);
  Icon icon6 = Icon(Icons.add);

  TextStyle liststyleservice = TextStyle(
      color: Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 18);

  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var list = widget.list;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: mainColor,
        title: Text(
          "اجراءات",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app_outlined), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            child: Text(
              "${list['courses_name_ar']}",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            color: mainColor,
          ),
          Column(
            children: [
              ListTile(
                  title: Text(
                    "رمز الدورة",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[800]),
                  ),
                  trailing: Text(
                    "${list['courses_id']}",
                    style: TextStyle(color: Colors.red),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(color: Colors.grey),
              ),
              ExpansionTile(
                onExpansionChanged: (status) {
                  if (status) {
                    setState(() {
                      icon2 = Icon(Icons.remove);
                    });
                  } else {
                    setState(() {
                      icon2 = Icon(Icons.add);
                    });
                  }
                },
                trailing: icon2,
                title: Text(
                  "وصف الدورة",
                  style: liststyleservice,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text("${list['courses_desc_ar']}"),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(color: Colors.grey),
              ),
              ExpansionTile(
                onExpansionChanged: (status) {
                  if (status) {
                    setState(() {
                      icon3 = Icon(Icons.remove);
                    });
                  } else {
                    setState(() {
                      icon3 = Icon(Icons.add);
                    });
                  }
                },
                trailing: icon3,
                title: Text(
                  "ساعات الدورة",
                  style: liststyleservice,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text("${list['courses_hour']} ساعة"),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(color: Colors.grey),
              ),
              ExpansionTile(
                onExpansionChanged: (status) {
                  if (status) {
                    setState(() {
                      icon4 = Icon(Icons.remove);
                    });
                  } else {
                    setState(() {
                      icon4 = Icon(Icons.add);
                    });
                  }
                },
                trailing: icon4,
                title: Text(
                  "الوقت اللازم لتنفيذ الحكم",
                  style: liststyleservice,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text("${list['courses_document']}"),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(color: Colors.grey),
              ),
              // RaisedButton(
              //   padding: EdgeInsets.symmetric(horizontal: 40),
              //   color: Colors.red,
              //   textColor: Colors.white,
              //   onPressed: () {},
              //   child: Text("طلب مذكرة"),
              // )
            ],
          ),
        ],
      ),
    );
  }
}

/*
طلب المذكرة 
1 - الاسم 
2 -  البريد الالكتروني
3 - رقم الهاتف 
4 - دروب دون للسعر 
5 - 4 - العنوان


*/

// AppBar(
//         toolbarHeight: 50,
//         elevation: 0,
//         backgroundColor: mainColor,
//         title: Text(
//           "الخدمة",
//           style: TextStyle(fontSize: 16),
//         ),
//         actions: [
//           IconButton(icon: Icon(Icons.search), onPressed: () {}),
//         ],
//       ),
