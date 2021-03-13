import 'package:cached_network_image/cached_network_image.dart';
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
    double mdw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        shape: Border.all(width: 0, color: Theme.of(context).primaryColor),
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
                        "${categories[index]['catexperts_name']}",
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
          Container(
            margin: EdgeInsets.only(top: 20),
            child: FutureBuilder(
              future: crud.writeData(
                linkExperts,
                {"id": idcat.toString(), "search": search.toString()},
              ),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error"));
                }
                if (snapshot.hasData) {
                  if (snapshot.data[0] == "falid") {
                    return Center(
                      child: Text("Not Courses"),
                    );
                  }

                  return GridView.count(
                    childAspectRatio: 1.3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: List.generate(snapshot.data.length, (index) {
                      return ListHomeExperts(
                          mdw: mdw, list: snapshot.data[index]);
                    }),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      )),
    );
  }
}

class ListHomeExperts extends StatelessWidget {
  final mdw;
  final list;
  const ListHomeExperts({Key key, this.mdw, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: mdw / 15),
        height: 140,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: mdw / 3,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 3,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 75,
                        padding: EdgeInsets.all(10),
                        child: CachedNetworkImage(
                          placeholder: (context, e) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, st, w) => Text("ERROR"),
                          imageUrl:
                              "$linkRootImage/experts/${list['experts_image']}",
                          fit: BoxFit.fill,
                          width: 75,
                          height: 75,
                        )),
                    Text(
                      "${list['experts_name']}",
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${list['experts_spec']}",
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
          ),
        ));
  }
}
