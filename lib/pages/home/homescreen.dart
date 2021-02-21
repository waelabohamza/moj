import 'package:flutter/material.dart';
import 'package:moj/pages/home/component/listbottom.dart';
import 'package:moj/pages/home/component/listhorizntal.dart';
import 'package:moj/pages/home/component/topcardcenter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List services = [
    {"name": "القضايا التجارية"},
    {"name": "التنفيذ"},
    {"name": "القضايا الجزائية"},
    {"name": "القضايا الادارية"},
  ];

  List questions = [
    {"name": "رفع الدعاوي الالكترونية"},
    {"name": "الكاتب العدل الالكتروني "},
    {"name": "طلب عبد الزواج"}
  ];

  List issues = [
    {
      "name": "شركات",
      "desc":
          "كن لا بد أن أوضح لك أن كل هذه الأفكار المغلوطة حول استنكار  النشوة وتمجيد الألم نشأت بالفعل"
    },
    {
      "name": "فردية",
      "desc":
          "كن لا بد أن أوضح لك أن كل هذه الأفكار المغلوطة حول استنكار  النشوة وتمجيد الألم نشأت بالفعل"
    },
    {
      "name": "جزائي",
      "desc":
          "كن لا بد أن أوضح لك أن كل هذه الأفكار المغلوطة حول استنكار  النشوة وتمجيد الألم نشأت بالفعل"
    }
  ];

  @override
  Widget build(BuildContext context) {
    double mdw = MediaQuery.of(context).size.width;

    return ListView(
      // controller: scrollController,
      children: [
        TopCardCenter(mdw: mdw),
        Container(
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.only(right: mdw / 14),
            child: Text(
              "الخدمات الشائعة",
              style: TextStyle(fontSize: 18, color: Colors.black),
            )),
        ListHorzintal(mdw: mdw, list: services, type: "service"),
        Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(right: mdw / 14),
            child: Text(
              "الاسئلة الشائعة",
              style: TextStyle(fontSize: 18, color: Colors.black),
            )),
        ListHorzintal(
          mdw: mdw,
          list: questions,
          type: "questions",
        ),
        Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(right: mdw / 14),
            child: Text(
              "الدورات",
              style: TextStyle(fontSize: 18, color: Colors.black),
            )),
        ListHorzintal(
          mdw: mdw,
          list: questions,
          type: "courses",
        ),
        Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(right: mdw / 14),
            child: Text(
              "القضايا",
              style: TextStyle(fontSize: 18, color: Colors.black),
            )),
        SizedBox(height: 10),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: issues.length,
            itemBuilder: (context, i) {
              return ListBottom(mdw: mdw, list: issues[i]);
            }),
        SizedBox(height: 30)
      ],
    );
  }
}
