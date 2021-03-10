import 'package:flutter/material.dart';
import 'package:moj/component/crud.dart';
import 'package:moj/const.dart';
import 'package:moj/pages/linkapi.dart';
import 'question.dart';

class Questions extends StatefulWidget {
  Questions({Key key}) : super(key: key);
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Questions>
    with SingleTickerProviderStateMixin {
      
  var search = "";
  TabController tc;
  Crud crud = new Crud();
  var idcat;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border.all(width: 0, color: mainColor),
        actions: [IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {})],
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
                future: crud.writeData(linkServices,
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
                        child: Text("Not questions"),
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
                          return ListServices(
                            questions: snapshot.data[i],
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

class ListServices extends StatelessWidget {
  final questions;
  const ListServices({Key key, this.questions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Text("${questions['services_name']}"),
          Spacer(),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Question(list: questions);
              }));
            },
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
