import 'package:flutter/material.dart';
import 'package:moj/const.dart';
import 'package:moj/main.dart';

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
                    "${sharedPrefs.getString('username')[0]}",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${sharedPrefs.getString('username')}"),
                    Text("${sharedPrefs.getString('email')}")
                  ],
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text("الخدمات"),
            leading: Icon(Icons.home_repair_service_sharp),
          ),
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
