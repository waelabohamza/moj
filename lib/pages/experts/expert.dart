import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moj/const.dart';
import 'package:moj/pages/linkapi.dart';
import 'package:url_launcher/url_launcher.dart';

class Expert extends StatefulWidget {
  final list;
  Expert({Key key, this.list}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Expert> {
  Icon icon1 = Icon(Icons.add);
  Icon icon2 = Icon(Icons.add);
  Icon icon3 = Icon(Icons.add);
  Icon icon4 = Icon(Icons.add);
  Icon icon5 = Icon(Icons.add);
  Icon icon6 = Icon(Icons.add);

  TextStyle liststyleservice = TextStyle(
      color: Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 15);

  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var list = widget.list;
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
              "${list['experts_name']}",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            color: Theme.of(context).primaryColor,
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: CachedNetworkImage(
                  placeholder: (context, e) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, st, w) => Text("ERROR"),
                  imageUrl: "$linkRootImage/experts/${list['experts_image']}",
                  fit: BoxFit.fill,
                  width: 200,
                  height: 200,
                ),
              ),
              ListTile(
                  title: Text(
                    "رمز",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[800]),
                  ),
                  trailing: Text(
                    "${list['experts_id']}",
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
                  "التخصص",
                  style: liststyleservice,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text("${list['experts_spec']}"),
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
                  "الخبرة",
                  style: liststyleservice,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text("${list['experts_experience']} سنوات"),
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
                    Text("$textcontactwhatsapp"),
                    SizedBox(width: 10),
                    FaIcon(FontAwesomeIcons.whatsapp),
                  ],
                ),
                color: Colors.green,
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 5),
              ),
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
