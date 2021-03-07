import 'package:flutter/material.dart';
import 'package:moj/component/crud.dart';
import 'package:moj/const.dart';
import 'package:moj/pages/linkapi.dart';

class Courses extends StatefulWidget {
  final categories;
  final index;
  final catid;
  Courses({Key key, this.categories, this.index, this.catid}) : super(key: key);
  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> with SingleTickerProviderStateMixin {
  var search = "";

  TabController tc;

  Crud crud = new Crud();

  var idcat;

  bool isLoading = false;

  List icons = [];

  @override
  void initState() {
    idcat = widget.catid == null
        ? widget.categories[0]['catcourses_id']
        : widget.catid;
    tc = new TabController(
        length: widget.categories.length,
        vsync: this,
        initialIndex: widget.index ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List categories = widget.categories;
    return Scaffold(
      appBar: AppBar(
        shape: Border.all(width: 0, color: mainColor),
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
              idcat = categories[indextab]['catcourses_id'];
            });
          },
          tabs: [
            ...List.generate(
                widget.categories.length,
                (index) => Tab(
                      iconMargin: EdgeInsets.only(bottom: 0),
                      child: Text(
                        "${categories[index]['catcourses_name_ar']}",
                        style: TextStyle(fontSize: 13),
                      ),
                      icon: Icon(
                        Icons.golf_course_outlined,
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
        backgroundColor: mainColor,
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
                future: crud.writeData(linkCourses,
                    {"id": idcat.toString(), "search": search.toString()}),
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
                        child: Text("Not Courses"),
                      );
                    }
                    return ListView.separated(
                        separatorBuilder: (context, i) {
                          return Divider();
                        },
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return ListCourses(
                            courses: snapshot.data[i],
                          );
                        });
                  }
                  return Center(child: CircularProgressIndicator());
                })
          ],
        ),
      ),
    );
  }
}

class ListCourses extends StatelessWidget{
  final courses;
  const ListCourses({Key key, this.courses}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Text("${courses['courses_name']}"),
          Spacer(),
          InkWell(
            onTap: () {},
            child: Column(children: [
              Icon(Icons.help_outline_outlined, size: 25, color: mainColor),
              Text("معلومات", style: TextStyle(color: Colors.red, fontSize: 13))
            ]),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {},
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
