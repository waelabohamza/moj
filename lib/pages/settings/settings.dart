import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moj/main.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        titleSpacing: 0,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.red),
        shape: Border.all(width: 0, color: Theme.of(context).primaryColor),
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "اجراءات",
          style: TextStyle(fontSize: 16),
        ),
 
   
      ),
      body: Container(),
    );
  }
}
