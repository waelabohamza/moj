import 'package:flutter/material.dart';
import 'package:moj/const.dart';

class Services extends StatefulWidget {
  Services({Key key}) : super(key: key);

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services>
    with SingleTickerProviderStateMixin {
  TabController tc;

  List categories = [
    {"name": "جميع الخدمات", "icon": "ss"},
    {"name": "الافراد", "icon": "ss"},
    {"name": "الشركات", "icon": "ss"},
    {"name": "الجزائية", "icon": "ss"},
    {"name": "الخدمات ذات الاولوية", "icon": "ss"},
  ];

  List services = [
    {"name": "تقديم المساعدة في المسائل المدنية"},
    {"name": "استرداد المطلوبين"},
    {"name": "نقل المحكوم عليه"}
  ];

  List icons = [];

  @override
  void initState() {
    tc = new TabController(length: categories.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border.all(width: 0 , color: mainColor),
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){})
        ],
        bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            controller: tc,
            tabs: [
              ...List.generate(
                  5,
                  (index) => Tab(
                        iconMargin: EdgeInsets.only(bottom: 0),
                        child: Text(
                          "${categories[index]['name']}",
                          style: TextStyle(fontSize: 13),
                        ),
                        icon: Icon(
                          Icons.medical_services_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                      ))
            ]),
        title: Text(
          'دليل الخدمات',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop() ; 
            }else {
              Navigator.of(context).pushNamed("home") ; 
            }
          },
        ),
        backgroundColor: mainColor,
      ),
      body: Container(
        child: ListView(
          children: [
            TextField(
              onChanged: (val) {},
              decoration: InputDecoration(
                  hintText: "ابدا البحث هنا ",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: InputBorder.none),
            ),
            ListView.separated(
                separatorBuilder: (context, i) {
                  return Divider();
                },
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: services.length,
                itemBuilder: (context, i) {
                  return ListServices(
                    services: services[i],
                  );
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
          Text("${services['name']}"),
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
