import 'package:flutter/material.dart';
import 'package:moj/const.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "القائمة",
              style: TextStyle(fontSize: 22),
            ),
          ),

          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Text(
                    "w",
                    style: TextStyle(color: Colors.white , fontSize: 30),
                  ),
                  backgroundColor: mainColor,
                ) , 
                SizedBox(width: 10) , 
                Text("wael@gmail.com")
              ],
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text("الخدمات"),
            leading: Icon(Icons.home_repair_service_sharp),
          ),
          // ExpansionTile(
          //   title: Text("المركز الاعلامي"),
          //   leading: Icon(Icons.medical_services_outlined),
          //   children: [
          //     ListTile(
          //       onTap: () {},
          //       title: Text("اخر الاخبار"),
          //       leading: Icon(Icons.assignment_outlined),
          //     ),
          //     ListTile(
          //       onTap: () {},
          //       title: Text("الصور"),
          //       leading: Icon(Icons.photo),
          //     ),
          //     ListTile(
          //       onTap: () {},
          //       title: Text("الفعاليات"),
          //       leading: Icon(Icons.insights_rounded),
          //     ),
          //   ],
          // ),
          ListTile(
            onTap: () {},
            title: Text("عن التطبيق"),
            leading: Icon(Icons.help_center_outlined),
          ),
          ListTile(
            onTap: () {},
            title: Text("اتصل بنا"),
            leading: Icon(Icons.contact_phone_outlined),
          ),
          ListTile(
            onTap: () {},
            title: Text("الاعدادات"),
            leading: Icon(Icons.settings),
          ),
          ListTile(
            onTap: () {},
            title: Text("تسجيل الخروج"),
            leading: Icon(Icons.exit_to_app),
          ),
        ],
      ),
    );
  }
}
