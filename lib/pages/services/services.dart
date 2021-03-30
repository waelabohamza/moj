import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:moj/component/animatelist.dart';
import 'package:moj/component/crud.dart';
import 'package:moj/pages/linkapi.dart';
import 'package:moj/pages/orders/addorderservice.dart';
import 'package:moj/pages/services/service.dart';

class Services extends StatefulWidget {
  final categories;
  final favorite;
  final index;
  final catid;

  Services({Key key, this.categories, this.index, this.catid, this.favorite})
      : super(key: key);
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services>
    with SingleTickerProviderStateMixin {
  var search = "";

  TabController tc;

  Crud crud = new Crud();

  var idcat;

  bool isLoading = false;

  List icons = [];

  @override
  void initState() {
    idcat = widget.catid == null ? "all" : widget.catid;
    tc = new TabController(
        length: widget.categories.length + 1,
        vsync: this,
        initialIndex: widget.index == null ? 0 : widget.index + 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List categories = widget.categories;
    var favorite = widget.favorite != null ? "yes" : "no";
    return Scaffold(
      appBar: AppBar(
        shape: Border.all(width: 0, color: Theme.of(context).primaryColor),
        actions: [IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {})],
        bottom: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          controller: tc,
          onTap: (indextab) {
            // Get Id For All Categories for Filter Body base on id categories
            setState(() {
              isLoading = true;
              if (indextab == 0) {
                idcat = "all";
              } else {
                idcat = categories[indextab - 1]['categories_id'];
                // -1 بسبب انو فيه كل الخدمات وهي مانها محسوبة من الاقسام
              }
            });
          },
          tabs: [
            Tab(
              iconMargin: EdgeInsets.only(bottom: 0),
              child: Text(
                "كل  الخدمات",
                style: TextStyle(fontSize: 13),
              ),
              icon: Icon(
                Icons.medical_services_outlined,
                size: 25,
                color: Colors.white,
              ),
            ),
            ...List.generate(
                widget.categories.length,
                (index) => Tab(
                      iconMargin: EdgeInsets.only(bottom: 0),
                      child: Text(
                        "${categories[index]['categories_name_ar']}",
                        style: TextStyle(fontSize: 13),
                      ),
                      icon: Icon(
                        Icons.medical_services_outlined,
                        size: 25,
                        color: Colors.white,
                      ),
                    ))
          ],
        ),
        title: Text(
          'دليل الخدمات',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pushNamed("home");
            }
          },
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        child: ListView(
          children: [
            TextField(
              onChanged: (val) {
                setState(() {
                  search = val;
                });
              },
              decoration: InputDecoration(
                  hintText: "ابدا البحث هنا ",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: InputBorder.none),
            ),
            FutureBuilder(
                future: crud.writeData(linkServices, {
                  "id": idcat.toString(),
                  "search": search.toString(),
                  "favorite": favorite.toString()
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      margin: EdgeInsets.only(top: 50),
                      child: new Center(
                        child: new CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data[0] == "falid") {
                      return Center(
                        child: Text("Not Services"),
                      );
                    }
                    return LiveList.options(
                      separatorBuilder: (context, i) {
                        return Divider();
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      options: options,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index,
                          Animation<double> animation) {
                        return FadeTransition(
                          opacity: Tween<double>(
                            begin: 0,
                            end: 1,
                          ).animate(animation),
                          // And slide transition
                          child: SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset(0, 1),
                                end: Offset.zero,
                              ).animate(animation),
                              // Paste you Widget
                              child:
                                  ListServices(services: snapshot.data[index])),
                        );
                      },
                    );
                    // return ListView.separated(
                    // separatorBuilder: (context, i) {
                    //   return Divider();
                    // },
                    //     shrinkWrap: true,
                    //     physics: NeverScrollableScrollPhysics(),
                    //     itemCount: snapshot.data.length,
                    //     itemBuilder: (context, i) {
                    //       return ListServices(
                    //         services: snapshot.data[i],
                    //       );
                    //     });
                  }
                  return Center(child: CircularProgressIndicator());
                })
          ],
        ),
      ),
    );
  }
}

class ListServices extends StatelessWidget {
  final services;
  const ListServices({Key key, this.services}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Text("${services['services_name']}"),
          Spacer(),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Service(list: services);
              }));
            },
            child: Column(children: [
              Icon(Icons.help_outline_outlined,
                  size: 25, color: Theme.of(context).primaryColor),
              Text("معلومات",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 13))
            ]),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddOrdersService(
                    servicesid: services['services_id'],
                    typeprice: services['services_typeprice']);
              }));
            },
            child: Column(children: [
              Icon(Icons.download_done_sharp, size: 25, color: Colors.green),
              Text("ابدا ", style: TextStyle(color: Colors.green, fontSize: 13))
            ]),
          )
        ],
      ),
    );
  }
}
