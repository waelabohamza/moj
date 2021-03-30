import 'dart:async';
import 'package:flutter/material.dart';
import 'package:moj/component/crud.dart';
import 'package:moj/main.dart';
import 'package:moj/pages/experts/experts.dart';
import 'package:moj/pages/home/component/listexperts.dart';
import 'package:moj/pages/home/component/listhorizntal.dart';
import 'package:moj/pages/home/component/topcardcenter.dart';
import 'package:moj/pages/linkapi.dart';
import 'package:moj/pages/questions/questions.dart';
import 'package:moj/pages/services/services.dart';
import 'package:show_up_animation/show_up_animation.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  var email = sharedPrefs.getString("email");

  var username = sharedPrefs.getString("username");

  Crud crud = new Crud();

  bool isLoading = true;

  PageController pageController;

  List listHomeDataServicesFavorite = [];
  List listHomeDataServicesCommon = [];
  List listHomeDataQuestions = [];
  List listHomeDataCourses = [];
  List listHomeDataExperts = [];
  List listHomeDataCategories = [];
  List listHomeDataCatCourse = [];
  List listHomeDataCatExperts = [];

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
    listHomeDataCatCourse.addAll(responsebody['catcourses']);
    listHomeDataCatExperts.addAll(responsebody['catexperts']);

    print("==================");
    print(listHomeDataExperts);
    print("==================");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startAnimate();
    });
    if (this.mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Completer<bool> completer = new Completer<bool>();

  @override
  void initState() {
    pageController = PageController(viewportFraction: 0.8);
    _getData();
    super.initState();
  }

  startAnimate() {
    Future.delayed(Duration(seconds: 3), () {
      int nextPage = pageController.page.round() + 1;
      if (nextPage == listHomeDataCategories.length) {
        nextPage = 0;
      }
      pageController
          .animateToPage(nextPage,
              duration: Duration(seconds: 1), curve: Curves.easeInOut)
          .then((_) => startAnimate());
    });
  }

  @override
  void dispose() {
    listHomeDataServicesFavorite.clear();
    listHomeDataCategories.clear();
    listHomeDataCourses.clear();
    listHomeDataQuestions.clear();
    listHomeDataServicesCommon.clear();
    listHomeDataExperts.clear();
    pageController.dispose();
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
              ShowUpAnimation(
                delayStart: Duration(microseconds: 0),
                animationDuration: Duration(seconds: 1),
                curve: Curves.bounceIn,
                direction: Direction.vertical,
                offset: -1,
                child: TopCardCenter(
                    mdw: mdw,
                    list: listHomeDataServicesFavorite,
                    listcat: listHomeDataCategories),
              ),
              ShowUpAnimation(
                delayStart: Duration(microseconds: 1),
                animationDuration: Duration(seconds: 1),
                curve: Curves.bounceIn,
                direction: Direction.horizontal,
                offset: -1,
                child: Container(
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
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Services(
                                    categories: listHomeDataCategories);
                              }));
                            })
                      ],
                    )),
              ),
              ShowUpAnimation(
                delayStart: Duration(microseconds: 1),
                animationDuration: Duration(seconds: 1),
                curve: Curves.bounceIn,
                direction: Direction.vertical,
                offset: -1,
                child: ListHorzintal(
                    mdw: mdw,
                    list: listHomeDataServicesCommon,
                    type: "service"),
              ),
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
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Questions();
                            }));
                          })
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
                list: listHomeDataCatCourse,
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
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Experts(
                                categories: listHomeDataCatExperts,
                              );
                            }));
                          })
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
              SizedBox(height: 10),
              Container(
                height: 170,
                child: PageView.builder(
                    controller: pageController,
                    itemCount: listHomeDataCategories.length,
                    itemBuilder: (context, i) {
                      return carousal(listHomeDataCategories, i, mdw);
                    }),
              ),
              SizedBox(height: 30),
            ],
          );
  }

  Widget carousal(list, i, mdw) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Services(
              index: i, categories: list, catid: list[i]['categories_id']);
        }));
      },
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: mdw / 14),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "${list[i]['categories_name_ar']}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Center(
                        child: Text(
                          "${list[i]['categories_desc_ar']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {},
                        child: Text(
                          "ابدا الخدمة",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
