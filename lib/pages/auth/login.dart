import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:moj/component/alert.dart';
import 'package:moj/component/crud.dart';
import 'package:moj/component/valid.dart';
import 'package:moj/const.dart';
import 'package:moj/main.dart';
import 'package:moj/pages/linkapi.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Crud crud = new Crud();

  bool isShowPass = true;

  // KEY FORM
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  // Controller
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  signIn() async {
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      var data = {"password": password.text, "email": email.text};
      showLoading(context);
      var responsebody = await crud.writeData(linkSignIn, data);
      if (responsebody['status'] == "success") {
        Navigator.of(context).pop();
        sharedPrefs.setString("id", responsebody['users']['users_id']);
        sharedPrefs.setString("username", responsebody['users']['users_name']);
        sharedPrefs.setString("email", responsebody['users']['users_email']);
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        showAlertOneChoose(context, "error", "خطأ",
            "كلمة المرور او البريد الالكتروني غير صحيح");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Center(
              child: Image.asset(
                "images/avatar.png",
                height: 120,
                width: 120,
              ),
            ),
            Center(
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Text(
                    "ALBALLAM",
                    style: TextStyle(fontSize: 30),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 60,
                    child: Text(
                      "Group",
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            Form(
                key: formstate,
                child: Column(children: [
                  SizedBox(height: 20),
                  bulidTextForm("البريد الالكتروني", Icons.email_outlined,
                      email, "email"),
                  SizedBox(height: 10),
                  bulidTextForm("كلمة المرور", Icons.lock_open_outlined,
                      password, "password"),
                  SizedBox(height: 30),
                  FlatButton(
                    color: Colors.grey[50],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Theme.of(context).primaryColor, width: 2)),
                    onPressed: () {
                      signIn();
                    },
                    child: Text("تسجيل الدخول"),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed("forgetPassword");
                    },
                    child: Text("هل نسيت كلمة المرور"),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed("signup");
                    },
                    child: Text("انشاء حساب جديد"),
                  ),
                ]))
          ],
        ),
      ),
    );
  }

  TextFormField bulidTextForm(hint, IconData icon, control, type) {
    return TextFormField(
      obscureText: type == "password" ? isShowPass : false,
      controller: control,
      validator: (val) {
        if (type == "email") {
          return validInput(val, 2, 60, "يكون البريد الالكتروني");
        }
        return null;
      },
      decoration: InputDecoration(
          suffixIcon: type == "password"
              ? Icon(Icons.remove_red_eye_outlined)
              : SizedBox(),
          prefixIcon: Icon(icon),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14)),
    );
  }
}
