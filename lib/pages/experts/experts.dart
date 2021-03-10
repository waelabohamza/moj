import 'package:flutter/material.dart';
import 'package:moj/component/crud.dart';
import 'package:moj/const.dart';
import 'package:moj/pages/linkapi.dart';

class Experts extends StatefulWidget {
  final categories;
  final index;
  final catid;
  Experts({Key key, this.categories, this.index, this.catid}) : super(key: key);

  @override
  _ExpertsState createState() => _ExpertsState();
}

class _ExpertsState extends State<Experts> with SingleTickerProviderStateMixin {
  TabController tc;

  var search = "";

  Crud crud = new Crud();

  var idcat;

  bool isLoading = false;
  @override
  void initState() {
    idcat = widget.catid == null
        ? widget.categories[0]['catexperts_id']
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
          // isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          controller: tc,
          onTap: (indextab) {
            // Get Id For All Categories for Filter Body base on id categories
            setState(() {
              isLoading = true;
              idcat = categories[indextab]['catexperts_id'];
              print("===================================");
              print(idcat);
            });
          },
          tabs: [
            ...List.generate(
                widget.categories.length,
                (index) => Tab(
                      iconMargin: EdgeInsets.only(bottom: 0),
                      child: Text(
                        "${categories[index]['catcourses_name']}",
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
          'دليل الخبراء',
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
            future: crud.writeData(
              linkExperts,
              {"id": idcat.toString(), "search": search.toString()},
            ),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                  crossAxisCount: 2 , 
                  children: List.generate(snapshot.data.length, (index) {
                             
                             

                  }),
                  );
              }
              return Center(child: CircularProgressIndicator());
            },
          )
        ],
      )),
    );
  }
}
