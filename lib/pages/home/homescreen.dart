import 'package:flutter/material.dart';
import 'package:moj/const.dart';
import 'package:moj/pages/home/component/listbottom.dart';
import 'package:moj/pages/home/component/listexperts.dart';
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

  List courses = [
    {"name": "خبير"},
    {"name": "حارس امين "},
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

  List experts = [
    {"image": "images/avatar.png", "name": "وائل", "job": "معاملات"},
    {"image": "images/avatar.png", "name": "ياسر", "job": "دعاوي"},
    {"image": "images/avatar.png", "name": "خالد", "job": "عقود"},
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
            padding: EdgeInsets.only(right: mdw / 14, left: mdw / 14),
            child: Row(
              children: [
                Text(
                  "الخدمات الشائعة",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Spacer(),
                InkWell(
                    child: Text(
                      "رؤية الجميع",
                      style: TextStyle(fontSize: 16, color: mainColor),
                    ),
                    onTap: () {})
              ],
            )),
        ListHorzintal(mdw: mdw, list: services, type: "service"),
        Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(right: mdw / 14, left: mdw / 14),
            child: Row(
              children: [
                Text(
                  "الاسئلة الشائعة",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Spacer(),
                InkWell(
                    child: Text(
                      "رؤية الجميع",
                      style: TextStyle(fontSize: 16, color: mainColor),
                    ),
                    onTap: () {})
              ],
            )
            ),
        ListHorzintal(
          mdw: mdw,
          list: questions,
          type: "questions",
        ),
        Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(right: mdw / 14, left: mdw / 14),
            child: Text(
              "الدورات",
              style: TextStyle(fontSize: 16, color: Colors.black),
            )),
        ListHorzintal(
          mdw: mdw,
          list: courses,
          type: "courses",
        ),
        SizedBox(height: 10),
        Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(right: mdw / 14, left: mdw / 14),
            child:  Row(
              children: [
                Text(
                  "الخبراء",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Spacer(),
                InkWell(
                    child: Text(
                      "رؤية الجميع",
                      style: TextStyle(fontSize: 16, color: mainColor),
                    ),
                    onTap: () {})
              ],
            )),
        ListExperts(mdw: mdw, list: experts),
        SizedBox(height: 10),
        Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(right: mdw / 14, left: mdw / 14),
            child: Text(
              "القضايا",
              style: TextStyle(fontSize: 16, color: Colors.black),
            )),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: issues.length,
            itemBuilder: (context, i) {
              return ListBottom(mdw: mdw, list: issues[i]);
            }),
        SizedBox(height: 30),
      ],
    );
  }
}
