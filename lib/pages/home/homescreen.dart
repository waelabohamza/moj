import 'package:flutter/material.dart';
import 'package:moj/component/crud.dart';
import 'package:moj/const.dart';
import 'package:moj/pages/home/component/listbottom.dart';
import 'package:moj/pages/home/component/listexperts.dart';
import 'package:moj/pages/home/component/listhorizntal.dart';
import 'package:moj/pages/home/component/topcardcenter.dart';
import 'package:moj/pages/linkapi.dart';
import 'package:moj/pages/services/service.dart';
import 'package:moj/pages/services/services.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Crud crud = new Crud();

  bool isLoading = true;

  List listHomeDataServicesFavorite = [];
  List listHomeDataServicesCommon = [];
  List listHomeDataQuestions = [];
  List listHomeDataCourses = [];
  List listHomeDataExperts = [];
  List listHomeDataCategories = [];

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

  _getData() async {
    setState(() {
      isLoading = true;
    });

    var responsebody = await crud.readData(linkHomeData);
    listHomeDataServicesFavorite.addAll(responsebody['servicesfavorite']);
    listHomeDataServicesCommon.addAll(responsebody['servicescommon']);
    listHomeDataExperts.addAll(responsebody['expertscommon']);
    listHomeDataQuestions.addAll(responsebody['questionscommon']);
    listHomeDataCourses.addAll(responsebody['coursescommon']);
    listHomeDataCategories.addAll(responsebody['categories']);

    print("==================");
    print(listHomeDataExperts);
    print("==================");

    if (this.mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  void dispose() {
    listHomeDataServicesFavorite.clear();
    listHomeDataCategories.clear();
    listHomeDataCourses.clear();
    listHomeDataQuestions.clear();
    listHomeDataServicesCommon.clear();
    listHomeDataExperts.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double mdw = MediaQuery.of(context).size.width;

    return isLoading == true
        ? Center(child: CircularProgressIndicator())
        : ListView(
            // controller: scrollController,
            children: [
              TopCardCenter(
                  mdw: mdw,
                  list: listHomeDataServicesFavorite,
                  listcat: listHomeDataCategories),
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
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                               return  Services(categories:listHomeDataCategories) ; 
                            }));
                          })
                    ],
                  )),
              ListHorzintal(
                  mdw: mdw, list: listHomeDataServicesCommon, type: "service"),
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
                  )),
              ListHorzintal(
                mdw: mdw,
                list: listHomeDataQuestions,
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
                list: listHomeDataCourses,
                type: "courses",
              ),
              SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(right: mdw / 14, left: mdw / 14),
                  child: Row(
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
              ListExperts(mdw: mdw, list: listHomeDataExperts),
              SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(right: mdw / 14, left: mdw / 14),
                  child: Text(
                    "القضايا",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  )),
              ListBottom(mdw: mdw, list: listHomeDataCategories),
              SizedBox(height: 30),
            ],
          );
  }
}
