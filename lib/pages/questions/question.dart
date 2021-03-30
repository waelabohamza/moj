import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moj/const.dart';
import 'package:url_launcher/url_launcher.dart';

class Question extends StatefulWidget {
  final list ; 
  Question({Key key , this.list}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Question> {
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
    var list = widget.list ; 
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "اجراءات",
          style: TextStyle(fontSize: 16),
        ),
        // leading: IconButton(
        //   icon: Icon(Icons.segment),
        //   onPressed: () {
        //     scaffoldkey.currentState.openDrawer();
        //   },
        // ),
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
              "${list['questions_name']}",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            color: Theme.of(context).primaryColor,
          ),
          Column(
            children: [
              ListTile(
                  title: Text(
                    "رمز السوأل",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[800]),
                  ),
                  trailing: Text(
                    "${list['questions_id']}",
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
                  "الجواب",
                  style: liststyleservice,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "${list['questions_answer']}"
                    ),
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
                  "المستندات المطلوبة",
                  style: liststyleservice,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                       "${list['questions_document']}"
                    ),
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
                    child: Text(
                      "${list['questions_time_ar']}"
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(color: Colors.grey),
              ),
                 SizedBox(height: 20),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () async {
                  String text = "اريد الاستفسار من اجل خدمات تطبيقاتكم";
                  String url =
                      'https://api.whatsapp.com/send/?phone=$phonewhatsapp&text=$text&app_absent=0';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("تواصل بطريقة اخرى"),
                    SizedBox(width: 10),
                    FaIcon(FontAwesomeIcons.whatsapp),
                  ],
                ),
                color: Colors.green,
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 5),
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
//         backgroundColor: Theme.of(context).primaryColor,
//         title: Text(
//           "الخدمة",
//           style: TextStyle(fontSize: 16),
//         ),
//         actions: [
//           IconButton(icon: Icon(Icons.search), onPressed: () {}),
//         ],
//       ),
