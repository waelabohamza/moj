import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moj/component/alert.dart';
import 'package:moj/component/crud.dart';
import 'package:moj/main.dart';
import 'package:moj/pages/linkapi.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Crud crud = new Crud();

  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var changelocal = Provider.of<ChangeLocal>(context);
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
      body: Container(
          // padding: EdgeInsets.all(10),
          child: ListView(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              child: Text("معلومات الحساب",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18))),
          Card(
            child: ExpansionTile(
              title: Text("تغيير اسم المستخدم"),
              children: [
                buildTextForm(
                    "ادخل هنا اسم المستخدم الجديد", username, "username")
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text("تغيير كلمة المرور "),
              children: [
                buildTextForm(
                    "ادخل هنا كلمة المرور الجديد", password, "password")
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(10),
              child: Text("اللغة",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18))),
          Card(
              child: ListTile(
            onTap: (){
                        var currentlang = sharedPrefs.getString("lang");
                        if (currentlang == "ar") {
                          changelocal.changeLocal(Locale("en", ""));
                        } else {
                          changelocal.changeLocal(Locale("ar", ""));
                        }
            },
            title: Text("تغيير اللغة"),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          ))
        ],
      )),
    );
  }

  Widget buildTextForm(
      String hint, TextEditingController textEditingController, String type) {
    return Container(
      child: TextFormField(
        onEditingComplete: () async {
          if (type == "username") {
            if (username.text.length > 3) {
              showLoading(context);
              var response = await crud.writeData(linkSettings, {
                "username": username.text,
                "id": sharedPrefs.getString("id")
              });

              if (response['status'] == "success")
                Navigator.of(context).pushReplacementNamed("home");
            } else {
              var mytitle = "هام";
              var mybody = "لا يمكن ان تكون كلمة المرور اقل من 3 احرف";
              showAlertOneChoose(context, "error", mytitle, mybody);
            }
          }
          if (type == "password") {
            if (password.text.length > 3) {
              showLoading(context) ; 
              var response = await crud.writeData(linkSettings, {
                "password": password.text,
                "id": sharedPrefs.getString("id")
              });
              if (response['status'] == "success")
                Navigator.of(context).pushReplacementNamed("home");
            } else {
              var mytitle = "هام";
              var mybody = "لا يمكن ان تكون كلمة المرور اقل من 3 احرف";
              showAlertOneChoose(context, "error", mytitle, mybody);
            }
          }
        },
        controller: textEditingController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            hintText: hint),
      ),
    );
  }
}
