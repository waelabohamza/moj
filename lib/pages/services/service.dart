import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:moj/const.dart';
import 'package:moj/pages/linkapi.dart';
import 'package:moj/pages/services/ApiServiceProvider.dart';
import 'package:moj/pages/services/pdfview.dart';
 
 

class Service extends StatefulWidget {
  final list;
  Service({Key key, this.list}) : super(key: key);

  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
 
  
 
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
    final list = widget.list;
    return Scaffold(
      appBar: AppBar(
        shape: Border.all(width: 0, color: Theme.of(context).primaryColor),
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
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
              "${list['services_name']}",
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
                    "رمز الخدمة",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[800]),
                  ),
                  trailing: Text(
                    "${list['services_id']}",
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
                      icon1 = Icon(Icons.remove);
                    });
                  } else {
                    setState(() {
                      icon1 = Icon(Icons.add);
                    });
                  }
                },
                trailing: icon1,
                title: Text(
                  "تفاصيل الخدمة",
                  style: liststyleservice,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text("${list['services_desc']}"
                        // "كن لا بد أن أوضح لك أن كل هذه الأفكار المغلوطة حول استنكار  النشوة وتمجيد الألم نشأت بالفعل، وسأعرض لك التفاصيل لتكتشف حقيقة وأساس تلك السعادة البشرية، فلا أحد يرفض أو يكره أو يتجنب الشعور بالسعادة، ",
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
                  "اجراءات الخدمة",
                  style: liststyleservice,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text("${list['services_procedures']}"),
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
                  "مستندات",
                  style: liststyleservice,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    // child: Text("${list['services_document']}"),
                    child: InkWell(child: Text("PDF"),onTap: () async {
                      final file = await  PDFApi.loadNetwork(linkRootPdf); 
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                               return PDFViewerPage(file: file) ; 
                      })); 
                    },),
                  ),
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
                  "رسوم الخدمة",
                  style: liststyleservice,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text("${list['services_fees']}"),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(color: Colors.grey),
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 40),
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () {},
                child: Text("طلب مذكرة"),
              )
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
